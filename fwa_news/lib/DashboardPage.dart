import 'package:flutter/material.dart';
import 'package:fwa_news/preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fwa_news/HelpClass/NewsImplementation.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  NewsImplementation post = new NewsImplementation();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //Функция вызывается при попытке обновить данные (refresh)
  Future<Null> _refresh() async {
    setState(() {});
    return;
  }

  //TODO Нормально реализовать дефолтное значение
  int _postCount = 10;

  @override
  void initState() {
    //Получение кол-ва постов для отображения
    SharedPreferencesHelper.getKeyValue("news_count").then((value) {
      if (value != false) {
        _postCount = int.parse(value);
      }
    });

    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text("Dashboard"),
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: FutureBuilder(
            future: post.postBuilder(count: _postCount),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child: snapshot.data,
                );
              } else {
                return SpinKitHourGlass(
                  color: Colors.lightBlue,
                  size: 50.0,
                );
              }
            },
          )),
    );
  }
}
