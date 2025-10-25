import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news/core/api_result/api_result.dart';
import 'package:news/core/base_state/base_state.dart';
import 'package:news/modules/home/data/repo/repo.dart';
import 'package:news/modules/home/data/repo/repo_imp.dart';
import '../../../../core/apis/api_manager/api_manager.dart';
import '../../../../core/categories/categories.dart';
import '../../data/models/news_response.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState());

  Category? selectedCategory;
  Source? selectedSource;
  late NewsRepo _repo;

  Future<void> init() async {
    await getSources();
    await getNews(null);
    // checkConnection();
  }

  Future<void> getNews(String? sourceId) async {
    emit(state.copyWith(getNewsState: LoadingState()));
    _repo = NewsRepoImp();
    try {
      var result = await _repo.getNews(sourceId ?? selectedSource!.id);
      switch (result) {
        case Success():
          emit(state.copyWith(
              getNewsState:
                  SuccessState<List<Articles>>(data: result.success)));

        case Error():
          emit(state.copyWith(getNewsState: ErrorState(message: result.error)));
      }
    } catch (e) {
      emit(state.copyWith(getNewsState: ErrorState(message: e.toString())));
    }
  }

  Future<void> getSources() async {
    emit(state.copyWith(getSourceState: LoadingState()));
    _repo = NewsRepoImp();

    try {
      var sources = await _repo.getSources(selectedCategory!.id);
      selectedSource = sources.first;
      emit(state.copyWith(getSourceState: SuccessState(data: sources)));
    } catch (e) {
      emit(state.copyWith(getSourceState: ErrorState(message: e.toString())));
    }
  }

  void onSelectedCategory(Category category) {
    selectedCategory = category;
    emit(state.copyWith());
  }

  void onBackToHomeScreen() {
    selectedCategory = null;
    emit(state.copyWith());
  }

  void onSearch() {
    emit(state.copyWith());
  }

  // void checkConnection() {
  //   final connectionChecker = InternetConnectionChecker.instance;
  //
  //   final subscription = connectionChecker.onStatusChange.listen(
  //     (InternetConnectionStatus status) {
  //       if (status == InternetConnectionStatus.connected) {
  //         emit(HasConnection());
  //       } else {
  //         emit(HasNotConnection());
  //       }
  //     },
  //   );
  // }

  // void onChangeSource(int index) {
  //   getNews(sources[index].id);
  // }
}
