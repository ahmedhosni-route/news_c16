import '../../../../core/api_result/api_result.dart';
import '../models/news_response.dart';

abstract class NewsRepo {
  Future<List<Source>> getSources(String categoryId);
  Future<ApiResult> getNews(String sourceId);
}
