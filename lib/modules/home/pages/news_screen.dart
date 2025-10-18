import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/apis/api_manager/api_manager.dart';
import 'package:news/core/apis/models/news_response.dart';
import 'package:news/core/categories/categories.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/home/cubit/news_cubit.dart';
import 'package:news/modules/home/cubit/news_state.dart';
import 'package:news/modules/home/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

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
            if (state is GetSourcesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetSourcesSuccessState) {
              List<Source> sources = state.sources;
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
            } else {
              return const Text("Error");
            }
          },
          buildWhen: (previous, current) {
            return current is GetSourcesSuccessState ||
                current is GetSourcesLoadingState ||
                current is GetSourcesErrorState;
          },
        ),
        BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {
            if(state is GetNewsLoadingState){
              showModalBottomSheet(context: context, builder: (context) {
                return const Center(child: CircularProgressIndicator(),);
              },);
            }else if(state is GetNewsSuccessState){
              Navigator.pop(context);
            }else if( state is GetNewsErrorState){
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
           if (state is GetNewsSuccessState) {
              List<Articles> articles = state.articles;
              return Expanded(
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    var article = articles[index];

                    return NewsWidget(article: article);
                  },
                ),
              );
            } else {

              return const Text("error");
            }
          },
          buildWhen: (previous, current) {
            return current is GetNewsSuccessState ||
                current is GetNewsErrorState ||
                current is GetNewsLoadingState;
          },
        ),
      ],
    );
  }
}
