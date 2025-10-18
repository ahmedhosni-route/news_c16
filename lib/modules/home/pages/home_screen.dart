import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/home/pages/news_screen.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsCubit(),
        child: BlocBuilder<NewsCubit , NewsState>(
          builder: (context, state) {
            var cubit  = context.watch<NewsCubit>();
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
                        cubit.onBackToHomeScreen();
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
                  cubit.selectedCategory?.name ?? "Home",
                  style: const TextStyle(color: Colors.white),
                ),
                actions:  [
                  InkWell(
                    onTap: () {
                      cubit.onSearch();
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: cubit.selectedCategory == null
                  ? CategoryScreen()
                  : NewsScreen(

                    ),
            );
          },
        ));
  }
}
