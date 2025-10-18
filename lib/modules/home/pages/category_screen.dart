import 'package:flutter/material.dart';

import '../../../core/categories/categories.dart';
import '../viewmodel/view_model.dart';
import '../widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.viewModel,
  });

  final NewsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: Category.categories.length,
        itemBuilder: (context, index) {
          var category = Category.categories[index];
          return CategoryWidget(
              onNav: viewModel.onSelectedCategory,
              category: category,
              isLeft: index % 2 == 0);
        },
      ),
    );
  }
}
