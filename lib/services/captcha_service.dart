import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piaoxingqiu/helpers/headers.dart';
import 'package:piaoxingqiu/config/app_config.dart';
import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/helpers/logger.dart';

class CaptchaService {
  Future<String> generateCaptcha(String phone) async {
    try {
      String baseUrl = AppConfig.baseUrl;
      final response = await http.post(
          Uri.parse('$baseUrl/cyy_gatewayapi/user/pub/v3/generate_photo_code'),
          body: jsonEncode({
            'cellphone': phone,
            "verifyCodeUseType": "USER_LOGIN",
          }),
          headers: createHeaders(null));

      logError(response.body);
      Response<Map<String, dynamic>> data =
          Response.fromJson(jsonDecode(response.body));
      logError(data.toString());
      if (data.statusCode == 200 && data.data?['baseCode'] != null) {
        return data.data!['baseCode']!;
      }
      throw Exception('Failed to generate photo code: ${data.comments}');
    } catch (e, stack) {
      logError('发送验证码失败', e, stack);
      throw Exception('Failed to generate photo code: $e');
    }
  }
}
