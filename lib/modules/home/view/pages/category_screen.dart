import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/categories/categories.dart';
import '../cubit/news_cubit.dart';
import '../widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<NewsCubit>();
    return ListView.builder(
      itemCount: Category.categories.length,
      itemBuilder: (context, index) {
        var category = Category.categories[index];
        return CategoryWidget(
            onNav: cubit.onSelectedCategory,
            category: category,
            isLeft: index % 2 == 0);
      },
    );
  }
}
