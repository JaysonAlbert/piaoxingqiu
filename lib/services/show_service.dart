import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:piaoxingqiu/models/response.dart';
import 'package:piaoxingqiu/config/app_config.dart';
import 'package:piaoxingqiu/models/show.dart';
import 'package:piaoxingqiu/models/show_session.dart';

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

  Future<ShowDetail> getShow({String showId = ""}) async {
    String baseUrl = AppConfig.baseUrl;

    const data = {
      "src": AppConfig.src,
      "merchantId": AppConfig.merchantId,
      "ver": AppConfig.ver,
      "appId": AppConfig.appId,
      "cityId": "4403",
      "source": "FROM_QUICK_ORDER",
      "siteId": "6268b22753245f055f21d7b5"
    };
    Uri uri = Uri.parse(
        '$baseUrl/cyy_gatewayapi/show/pub/v5/show/$showId/static');
    uri.replace(queryParameters: data);
    final response = await http.get(uri);

    Response<Map<String, dynamic>> responseData =
        Response.fromJson(jsonDecode(response.body));

    if (responseData.statusCode == 200) {
      return ShowDetail.fromJson(responseData.data!);
    }
    throw Exception(responseData.comments);
  }

  Future<List<ShowSession>> getSession(String showId) async {
    String baseUrl = AppConfig.baseUrl;

    final response = await http.get(Uri.parse(
        '$baseUrl//cyy_gatewayapi/show/pub/v5/show/$showId/sessions'));
    Response<List<dynamic>> responseData =
        Response.fromJson(jsonDecode(response.body));

    if (responseData.statusCode == 200) {
      return responseData.data!
          .map<ShowSession>((item) => ShowSession.fromJson(item))
          .toList();
    }
    throw Exception(responseData.comments);
  }
}
