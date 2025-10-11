import 'package:flutter/material.dart';
import 'package:news/modules/splash/pages/splash_screen.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey ,

      home: SplashScreen(),
    );
  }
}


extension Navigate on Widget {
  go (){
    Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) {
      return this;
    },));

}
  goReplace (){
    Navigator.pushReplacement(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) {
      return this;
    },));}
}