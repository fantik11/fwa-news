import 'package:flutter/material.dart';
import 'package:fwa_news/Helpers/preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fwa_news/Core/Implementation/NewsImplementation.dart';
import 'package:fwa_news/settings.dart';

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

  int _postCount = Settings.DEFAULT_POSTS_SHOW_NUMBER;

  @override
  void initState() {
    //Получение кол-ва постов для отображения
    SharedPreferencesHelper.getKeyValue("news_count").then((value) {
      if (value != false) {
        _postCount = int.parse(value);
      }
    });

    super.initState();
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
        ),
      ),
    );
  }
}
