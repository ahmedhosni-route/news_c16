import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/core/apis/api_manager/api_manager.dart';
import 'package:news/core/apis/models/news_response.dart';
import 'package:news/core/categories/categories.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/home/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

import '../widgets/news_widget.dart';

class NewsScreen extends StatefulWidget {
  final Category category;
  final NewsViewModel viewModel;
  const NewsScreen(
      {super.key, required this.category, required this.viewModel});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Source? selectedSource;
  @override
  void initState() {
    widget.viewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            switch (viewModel.getSourceState) {
              // TODO: Handle this case.
              NewsState.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
              // TODO: Handle this case.
              NewsState.success => DefaultTabController(
                  length: viewModel.sources.length,
                  child: TabBar(
                    onTap: viewModel.onChangeSource,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    dividerColor: Colors.transparent,
                    tabs: viewModel.sources.map(
                      (e) {
                        return Tab(
                          text: e.name,
                        );
                      },
                    ).toList(),
                  ),
                ),

              // TODO: Handle this case.
              NewsState.error => const Text("error"),
            },
            switch (viewModel.getNewsState) {
              // TODO: Handle this case.
              NewsState.loading => const Expanded(
                child: Center(
                    child: CircularProgressIndicator(),
                  ),
              ),
              // TODO: Handle this case.
              NewsState.success => Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.articles.length,
                    itemBuilder: (context, index) {
                      var article = viewModel.articles[index];

                      return NewsWidget(article: article);
                    },
                  ),
                ),
              // TODO: Handle this case.
              NewsState.error => const Text("error"),
            }
          ],
        );
      },
    );
  }
}
