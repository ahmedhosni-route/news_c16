import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/base_state/base_state.dart';
import '../../data/models/news_response.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';
import '../widgets/news_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsCubit cubit;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        cubit.init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.watch<NewsCubit>();
    return Column(
      children: [
        BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            switch(state.getSourceState){
              case null:
                // TODO: Handle this case.
                return SizedBox();
              case LoadingState():
               return  Center(
                 child: CircularProgressIndicator(),
               );
              case SuccessState():
                List<Source> sources = (state.getSourceState as SuccessState).data;
                return DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    onTap: (value) {
                      cubit.getNews(sources[value].id);
                    },
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    dividerColor: Colors.transparent,
                    tabs: sources.map(
                          (e) {
                        return Tab(
                          text: e.name,
                        );
                      },
                    ).toList(),
                  ),
                );
              case ErrorState():
               return const Text("Error");
            }
          },
          // buildWhen: (previous, current) {
          //   return current is GetSourcesSuccessState ||
          //       current is GetSourcesLoadingState ||
          //       current is GetSourcesErrorState;
          // },
        ),
        BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {

            switch(state.getNewsState){

              case LoadingState() :
                return Center(child: CircularProgressIndicator(),);
              case SuccessState() :
                List<Articles> articles = state.getNewsState?.data??[];
                return Expanded(
                    child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          var article = articles[index];

                          return NewsWidget(article: article);
                        },
                      ),
                      onRefresh: () async {
                        await cubit.init();
                      },
                    ));
              case ErrorState():
                return Center(child: Text((state.getNewsState as ErrorState).message??""),);
              case null:
                return SizedBox();
            }

            // if (state is GetNewsSuccessState) {
            //
            // } else {
            //   return const Text("error");
            // }
          },
          // buildWhen: (previous, current) {
          //   return current is GetNewsSuccessState ||
          //       current is GetNewsErrorState ||
          //       current is GetNewsLoadingState;
          // },
        ),
      ],
    );
  }
}
