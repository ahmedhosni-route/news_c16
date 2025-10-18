import '../../../core/apis/models/news_response.dart';

sealed class NewsState{}

class InitState extends NewsState{}

class GetNewsSuccessState extends NewsState{
  List<Articles> articles;
  GetNewsSuccessState(this.articles);
}
class GetNewsErrorState extends NewsState{}
class GetNewsLoadingState extends NewsState{}

class GetSourcesSuccessState extends NewsState{
  List<Source> sources;
  GetSourcesSuccessState(this.sources);
}
class GetSourcesErrorState extends NewsState{
  String error;
  GetSourcesErrorState(this.error);
}
class GetSourcesLoadingState extends NewsState{}


class OnSelectedCategoryState extends NewsState{}
class OnBackToHomeState extends NewsState{}

class OnSearch extends NewsState{}