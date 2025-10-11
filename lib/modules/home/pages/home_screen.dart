import 'package:flutter/material.dart';
import 'package:news/core/apis/api_manager/api_manager.dart';
import 'package:news/core/categories/categories.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/home/pages/news_screen.dart';
import 'package:news/modules/home/widgets/category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black
                  )
                  ,child: Center(
                    child: Text("NEWS",style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),),
                  )),
            ),
            
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectedCategory = null;
                setState(() {

                });
              },
              title: Text("Go to Home"),
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
          selectedCategory?.name ?? "Home",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
      body: selectedCategory == null
          ? Expanded(
              child: ListView.builder(
                itemCount: Category.categories.length,
                itemBuilder: (context, index) {
                  var category = Category.categories[index];
                  return CategoryWidget(
                      onNav: (value) {
                        selectedCategory = value;
                        setState(() {});
                      },
                      category: category,
                      isLeft: index % 2 == 0);
                },
              ),
            )
          : NewsScreen(category: selectedCategory!,),
    );
  }
}
