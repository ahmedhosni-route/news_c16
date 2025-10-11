import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/core/apis/api_manager/api_manager.dart';
import 'package:news/core/apis/models/news_response.dart';
import 'package:news/core/categories/categories.dart';
import 'package:news/core/theme/app_colors.dart';

class NewsScreen extends StatefulWidget {
  final Category category;
  const NewsScreen({super.key, required this.category});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Source? selectedSource;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var sources = snapshot.data ?? [];
          if(sources.isNotEmpty){
            selectedSource ??= sources.first;

          }
          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                child: TabBar(
                  onTap: (value) {
                    selectedSource = sources[value];
                    setState(() {});
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
              ),
              Expanded(
                child: selectedSource == null? SizedBox() : FutureBuilder(
                  future: ApiManager.getNews(selectedSource!.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var articles = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          var article = articles[index];
                          return FadeInUp(
                            delay: Duration(milliseconds: 50 * index + 100),
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        article.urlToImage ?? "",
                                        height: 180,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const SizedBox(
                                            height: 180,
                                            child: Center(
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    article.title ?? "",
                                    style: const TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "By : ${article.author}",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Text(
                                        article.publishedAt?.substring(0, 10) ??
                                            "",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
