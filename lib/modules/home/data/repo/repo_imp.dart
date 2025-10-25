import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news/core/api_result/api_result.dart';
import 'package:news/modules/home/data/data_source/locale_data_source.dart';
import 'package:news/modules/home/data/models/news_response.dart';
import 'package:news/modules/home/data/repo/repo.dart';

import '../data_source/remote_data_source.dart';

class NewsRepoImp implements NewsRepo {
  late RemoteDataSource _remoteDataSource;
  late LocaleDataSource _localeDataSource;

  @override
  Future<ApiResult> getNews(String sourceId) async {
    try {
      final bool isConnected =
          await InternetConnectionChecker.instance.hasConnection;
      if (isConnected) {
        _remoteDataSource = RemoteDataSource();
        _localeDataSource = LocaleDataSource();
        var response = await _remoteDataSource.getNews(sourceId);
        if (response.statusCode == 200) {
          var data = NewsResponse.fromJson(response.data);
          await _localeDataSource.setNews(response.data);
          return Success(success: data.articles ?? []) ;
        } else {
          return Error(error: "this Error");
        }
      } else {
        _localeDataSource = LocaleDataSource();
        var response = await _localeDataSource.getNews();
        if (response != null) {
          var data = NewsResponse.fromJson(response);
          return Success(success: data.articles ?? []) ;
        } else {
          return Error(error: "this Error");
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<Source>> getSources(String categoryId) async {
    try {
      List<Source> sources = [];
      bool isConnection =
          await InternetConnectionChecker.instance.hasConnection;
      if (isConnection) {
        _remoteDataSource = RemoteDataSource();
        _localeDataSource = LocaleDataSource();

        var response = await _remoteDataSource.getSources(categoryId);
        if (response.statusCode == 200) {
          await _localeDataSource.setSources(response.data);
          var data = response.data["sources"];
          for (var e in data) {
            sources.add(Source.fromJson(e));
          }
          return sources;
        } else {
          throw response.data;
        }
      } else {
        _localeDataSource = LocaleDataSource();
        var response = await _localeDataSource.getSources();
        if (response != null) {
          var data = response["sources"];

          for (var e in data) {
            sources.add(Source.fromJson(e));
          }
          return sources;
        } else {
          return [];
        }
      }
    } catch (e, s) {
      print(e);
      print(s);

      rethrow;
    }
  }
}
