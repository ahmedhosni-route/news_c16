import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/main.dart';

import '../../home/view/pages/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Expanded(child: ZoomIn(child: Image.asset("assets/logos/news_logo.png"))),
          FadeInUp(
              delay: const Duration(seconds: 2),
              onFinish: (direction) {
                const HomeScreen().goReplace();
              },
              child: Image.asset("assets/logos/logo_route.png",width: 200,))
        ],
      ),
    );
  }
}
