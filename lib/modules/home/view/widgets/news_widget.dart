import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/news_response.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.article,
  });

  /// the object of the article
  final Articles article;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      // delay: Duration(milliseconds: 50 * index + 100),
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
                child: CachedNetworkImage(
                 imageUrl:  article.urlToImage ?? "",
                  height: 180,
                  fit: BoxFit.cover,
                  width: double.infinity,
                   placeholder: (context, url) {
                     return const Center(child: CircularProgressIndicator(),);
                   },
                   errorWidget:
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
  }
}
