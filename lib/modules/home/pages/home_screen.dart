import 'package:flutter/material.dart';
import 'package:news/core/apis/api_manager/api_manager.dart';
import 'package:news/core/categories/categories.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/home/pages/news_screen.dart';
import 'package:news/modules/home/viewmodel/view_model.dart';
import 'package:news/modules/home/widgets/category_widget.dart';
import 'package:provider/provider.dart';

import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsViewModel viewModel;
  @override
  void initState() {
    viewModel = NewsViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<NewsViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: DrawerHeader(
                        decoration: BoxDecoration(color: Colors.black),
                        child: Center(
                          child: Text(
                            "NEWS",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      viewModel.onBackToHomeScreen();
                    },
                    title: const Text("Go to Home"),
                  )
                ],
              ),
            ),
            backgroundColor: AppColors.black,
            appBar: AppBar(
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: Text(
                viewModel.selectedCategory?.name ?? "Home",
                style: const TextStyle(color: Colors.white),
              ),
              actions: const [
                Icon(
                  Icons.search,
                  color: Colors.white,
                )
              ],
            ),
            body: viewModel.selectedCategory == null
                ? CategoryScreen(viewModel: viewModel)
                : NewsScreen(
              viewModel: viewModel,
                    category: viewModel.selectedCategory!,
                  ),
          );
        },
      ),
    );
  }
}
