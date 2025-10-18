// import 'package:flutter/material.dart';
// import 'package:news/core/apis/api_manager/api_manager.dart';
//
// import '../../../core/apis/models/news_response.dart';
// import '../../../core/categories/categories.dart';
//
// class NewsViewModel extends ChangeNotifier {
//   final ApiManager _apiManager = ApiManager();
//   Category? selectedCategory;
//
//
//   List<Articles> articles = [];
//   List<Source> sources = [];
//
//
//   NewsState getNewsState = NewsState.loading;
//   NewsState getSourceState = NewsState.loading;
//
//
//   Future<void> init() async {
//     articles.clear();
//     notifyListeners();
//     await getSources();
//     await getNews(null);
//   }
//
//   Future<void> getNews(String? sourceId) async {
//     articles.clear();
//     getNewsState = NewsState.loading;
//     notifyListeners();
//     try {
//       articles = await _apiManager.getNews(sourceId ?? sources.first.id);
//       getNewsState = NewsState.success;
//       notifyListeners();
//     } catch (e, s) {
//       getNewsState = NewsState.error;
//       notifyListeners();
//       print(e);
//       print(s);
//     }
//   }
//
//   Future<void> getSources() async {
//     getSourceState = NewsState.loading;
//     notifyListeners();
//     try {
//       sources = await _apiManager.getSources(selectedCategory!.id);
//       getSourceState = NewsState.success;
//       notifyListeners();
//     } catch (e, s) {
//       getSourceState = NewsState.error;
//
//       print(e);
//       print(s);
//     }
//   }
//
//   void onSelectedCategory(Category category) {
//     selectedCategory = category;
//     notifyListeners();
//   }
//
//   void onBackToHomeScreen() {
//     selectedCategory = null;
//     notifyListeners();
//   }
//
//   void onChangeSource(int index) {
//     getNews(sources[index].id);
//   }
//
// }
//
// // enum NewsState { loading, success, error }
