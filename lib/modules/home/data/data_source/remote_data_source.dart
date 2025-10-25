import '../models/news_response.dart';
import 'package:dio/dio.dart';

class RemoteDataSource {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://newsapi.org/v2/", headers: {
    "x-api-key": "f556556720b043808f44291838842268",
  }));


  Future<Response> getNews(String sourceId) async {
    return _dio.get("everything", queryParameters: {
      "sources": sourceId,
    });
  }

  Future<Response> getSources(String categoryId) async {
    return _dio.get("top-headlines/sources",
        queryParameters: {"category": categoryId});
  }
}
