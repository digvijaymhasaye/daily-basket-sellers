import 'package:daily_basket_sellers/views/home_view.dart';
import 'package:daily_basket_sellers/views/sign_in_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Basket Sellers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3B916B),
        accentColor: Color(0xFF65BB9D),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Ubuntu',
        
        // backgroundColor: Colors.white,
      ),
      // home: SignInView(),
      home: Home(),
    );
  }
}