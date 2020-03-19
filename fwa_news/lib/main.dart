import 'package:flutter/material.dart';
import 'package:fwa_news/Widgets/DashboardPage.dart';
import 'package:fwa_news/Widgets/SplashPage.dart';
import "package:fwa_news/Widgets/LoginPage.dart";
import 'package:fwa_news/Core/Frame.dart';
import 'Routes/Routes.dart';
import 'package:fwa_news/Widgets/EditPostPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        Routes.LOGIN: (context) => LoginPage(),
        Routes.DASHBOARD: (context) => DashboardPage(),
        Routes.FRAME: (context) => Frame(),
        Routes.EDIT_POST: (context) => EditPostPage(),
      },
    );
  }
}

