import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/home/cubit/news_state.dart';
import '../../../core/apis/api_manager/api_manager.dart';
import '../../../core/apis/models/news_response.dart';
import '../../../core/categories/categories.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitState());

  final ApiManager _apiManager = ApiManager();
  Category? selectedCategory;
  Source? selectedSource;

  Future<void> init() async {
    await getSources();
    await getNews(null);
  }

  Future<void> getNews(String? sourceId) async {
    emit(GetNewsLoadingState());
    try {
      var articles = await _apiManager.getNews(sourceId ?? selectedSource!.id);
      emit(GetNewsSuccessState(articles));
    } catch (e, s) {
      emit(GetNewsErrorState());
    }
  }

  Future<void> getSources() async {
    emit(GetSourcesLoadingState());
    try {
      var sources = await _apiManager.getSources(selectedCategory!.id);
      selectedSource = sources.first;
      emit(GetSourcesSuccessState(sources));
    } catch (e, s) {
      emit(GetSourcesErrorState(e.toString()));
    }
  }

  void onSelectedCategory(Category category) {
    selectedCategory = category;
    emit(OnSelectedCategoryState());
  }

  void onBackToHomeScreen() {
    selectedCategory = null;
    emit(OnBackToHomeState());
  }

  void onSearch() {
    emit(OnSearch());
  }

  // void onChangeSource(int index) {
  //   getNews(sources[index].id);
  // }
}
