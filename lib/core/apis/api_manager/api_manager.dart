import 'package:dio/dio.dart';
import 'package:news/core/apis/models/news_response.dart';

class ApiManager {
   final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://newsapi.org/v2/", headers: {
    "x-api-key": "f556556720b043808f44291838842268",
  }));
   Future<List<Articles>> getNews(String sourceId) async {
    try {
      var response =
          await _dio.get("everything", queryParameters: {"sources": sourceId,});
      if (response.statusCode == 200) {
        var data = NewsResponse.fromJson(response.data);
        return data.articles ?? [];
      } else {
        throw response.data;
      }
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }
   Future<List<Source>> getSources(String categoryId) async {
    try {
      List<Source> sources = [];
      var response =
          await _dio.get("top-headlines/sources", queryParameters: {"category": categoryId});
      if (response.statusCode == 200) {
        var data = response.data["sources"];
        for(var e in data){
          sources.add(Source.fromJson(e));
        }
        return sources;
      } else {
        throw response.data;
      }
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }
}
