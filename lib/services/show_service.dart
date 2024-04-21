import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/config/app_config.dart';
import 'package:piaoxingqiu/models/show.dart';

class ShowService {
  Future<PageShowData> getShows(
      {String keyword = "", int length = 10, int pageNo = 1}) async {
    String baseUrl = AppConfig.baseUrl;

    int offset = (pageNo - 1) * length;
    final response = await http.get(Uri.parse(
        '$baseUrl/cyy_gatewayapi/home/pub/v3/show_list/search?keyword=$keyword&length=$length&offset=$offset'));

    Response<Map<String, dynamic>> responseData =
        Response.fromJson(jsonDecode(response.body));

    if (responseData.statusCode == 200) {
      return PageShowData.fromJson(responseData.data!);
    }
    throw Exception(responseData.comments);
  }
}
