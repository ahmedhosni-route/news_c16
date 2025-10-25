import 'package:news/core/base_state/base_state.dart';

import '../../data/models/news_response.dart';

 class NewsState{
   BaseState<List<Articles>>? getNewsState;
   BaseState? getSourceState;
   NewsState({this.getNewsState , this.getSourceState});

   NewsState copyWith(
       {BaseState<List<Articles>>? getNewsState , BaseState? getSourceState}
       ){
     return NewsState(
         getNewsState: getNewsState??this.getNewsState,
         getSourceState: getSourceState??this.getSourceState,
     );
   }
 }
//
// class InitState extends NewsState{}
//
// class GetNewsSuccessState extends NewsState{
//   List<Articles> articles;
//   GetNewsSuccessState(this.articles);
// }
// class GetNewsErrorState extends NewsState{}
// class GetNewsLoadingState extends NewsState{}
//
// class GetSourcesSuccessState extends NewsState{
//   List<Source> sources;
//   GetSourcesSuccessState(this.sources);
// }
// class GetSourcesErrorState extends NewsState{
//   String error;
//   GetSourcesErrorState(this.error);
// }
// class GetSourcesLoadingState extends NewsState{}
//
//
// class OnSelectedCategoryState extends NewsState{}
// class OnBackToHomeState extends NewsState{}
//
// class OnSearch extends NewsState{}
//
// class HasConnection extends NewsState{}
// class HasNotConnection extends NewsState{}