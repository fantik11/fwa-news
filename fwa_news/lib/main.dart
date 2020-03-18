import 'package:flutter/material.dart';
import 'package:fwa_news/DashboardPage.dart';
import "SplashPage.dart";
import "LoginPage.dart";
import 'HelpClass/Frame.dart';
import 'DashboardPage.dart';
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

