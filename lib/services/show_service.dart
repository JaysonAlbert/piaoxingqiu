import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/config/app_config.dart';

class ShowService {
  Future<List<Map<String, dynamic>>> getShows() async {
    String baseUrl = AppConfig.baseUrl;

    final response = await http.get(Uri.parse(
        '$baseUrl/cyy_gatewayapi/home/pub/v3/show_list/search?keyword='));

    Response<Map<String, dynamic>> responseData =
        Response.fromJson(jsonDecode(response.body));

    if (responseData.statusCode == 200) {
      return responseData.data!['searchData'];
    }
    throw Exception(responseData.comments);
  }
}
