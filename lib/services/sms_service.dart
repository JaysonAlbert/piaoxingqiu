import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piaoxingqiu/helpers/headers.dart';
import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/config/app_config.dart';

class SmsService {
  Future<void> sendVerifyCode(String phone, String photoCode) async {
    String baseUrl = AppConfig.baseUrl;

    var req = {
      "src": AppConfig.src,
      "merchantId": AppConfig.merchantId,
      "ver": AppConfig.ver,
      "appId": AppConfig.appId,
      "verifyCodeUseType": "USER_LOGIN",
      "cellphone": phone,
      "messageType": "MOBILE",
      "token": photoCode
    };

    final response = await http.post(
        Uri.parse('$baseUrl/cyy_gatewayapi/user/pub/v3/send_verify_code'),
        body: jsonEncode(req),
        headers: createHeaders(null));

    Response<bool> data = Response.fromJson(jsonDecode(response.body));
    print(data.toString());
    if (data.statusCode == 200 && data.data == true) {
      return;
    }
    throw Exception(data.comments);
  }
}
