import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piaoxingqiu/helpers/headers.dart';
import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/config/app_config.dart';

class UserService {
  Future<Map<String, dynamic>> login(String phone, String verifyCode) async {
    String baseUrl = AppConfig.baseUrl;

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

    print(response.body);
    Response<Map<String, dynamic>> data =
        Response.fromJson(jsonDecode(response.body));
    print(data.toString());
    if (data.statusCode == 200 && data.data != null) {
      return data.data!;
    }
    throw Exception(data.comments);
  }
}
