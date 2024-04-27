import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piaoxingqiu/helpers/headers.dart';
import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/config/app_config.dart';
import 'package:piaoxingqiu/services/privilege_service.dart';
import 'package:piaoxingqiu/models/order.dart';
import 'dart:math' as math;

import 'package:piaoxingqiu/services/shared_prefrences_service.dart';
import 'package:piaoxingqiu/helpers/logger.dart';

class UserService {
  String baseUrl = AppConfig.baseUrl;

  Future<Map<String, dynamic>> login(String phone, String verifyCode) async {
    var req = {
      "src": AppConfig.src,
      "merchantId": AppConfig.merchantId,
      "ver": AppConfig.ver,
      "appId": AppConfig.appId,
      "cellphone": phone,
      "verifyCode": verifyCode,
      "unionId": "oUXT6s14sutGyOMGkhmee_Dzcgi4",
      "openId": "oIFIO5JUmCniUnoVOlrZ4L-IjgBQ",
    };

    final response = await http.post(
        Uri.parse(
            '$baseUrl/cyy_gatewayapi/user/pub/v3/wx/mini/cellphone_login_or_register'),
        body: jsonEncode(req),
        headers: createHeaders(null));

    Response<Map<String, dynamic>> data =
        Response.fromJson(jsonDecode(response.body));
    logError(data.toString());
    if (data.statusCode == 200 && data.data != null) {
      return data.data!;
    }
    throw Exception(data.comments);
  }

  void refreshToken() async {
    String? refreshToken = await SharedPreferencesService().refreshToken;
    var req = {
      "src": AppConfig.src,
      "merchantId": AppConfig.merchantId,
      "ver": AppConfig.ver,
      "appId": AppConfig.appId,
      "refreshToken": refreshToken
    };
    Map<String, String> headers = PrivilegeService().getHeaders();
    final response = await http.post(
        Uri.parse(
            "$baseUrl/cyy_gatewayapi/user/pub/v3/refresh_token?refreshToken=$refreshToken"),
        headers: headers,
        body: jsonEncode(req));

    Response<Map<String, dynamic>> data =
        Response.fromJson(jsonDecode(response.body));
    if (data.statusCode == 200 && data.data != null) {
      SharedPreferencesService().setAccessToken(data.data!["accessToken"]);
      SharedPreferencesService().setRefreshToken(data.data!["refreshToken"]);
    } else {
      throw Exception(data.comments);
    }
  }

  Future<PreOrderResult> perOrder(OrderConfig orderConfig,
      {isRetry = false}) async {
    String baseUrl = AppConfig.baseUrl;

    Map<String, dynamic> data = {
      "src": AppConfig.src,
      "merchantId": AppConfig.merchantId,
      "ver": AppConfig.ver,
      "appId": AppConfig.appId,
      "priorityId": "",
      "items": [
        {
          "sku": {
            "skuId": orderConfig.seatPlanId,
            "skuType": "SINGLE",
            "ticketPrice": orderConfig.price,
            "qty": orderConfig.qty,
            "ticketItems": _getTicketItems(orderConfig.qty)
          },
          "spu": {
            "showId": orderConfig.showId,
            "sessionId": orderConfig.sessionId
          }
        }
      ]
    };

    var headers = PrivilegeService().getHeaders();
    String url = "$baseUrl/cyy_gatewayapi/trade/buyer/order/v5/pre_order";
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));

    Response<Map<String, dynamic>> responseBody =
        Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    if (responseBody.statusCode == 200) {
      return PreOrderResult.fromJson(responseBody.data!);
    } else if ((responseBody.statusCode == 15012007 ||
            responseBody.statusCode == 15012010) &&
        !isRetry) {
      refreshToken();
      return perOrder(orderConfig, isRetry: true);
    } else {
      throw Exception(responseBody.comments);
    }
  }

  List<Map<String, dynamic>> _getTicketItems(int qty) {
    return List.generate(
        qty,
        (index) => {
              "id":
                  "${DateTime.now().millisecondsSinceEpoch}1000${math.Random().nextInt(100).toString().padLeft(5, '0')}"
            });
  }
}
