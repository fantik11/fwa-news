import 'package:flutter/material.dart';
import 'package:fwa_news/HelpClass/FindNewsImplementation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FindNewsPage extends StatefulWidget {
  FindNewsPage({Key key}) : super(key: key);

  @override
  _FindNewsPageState createState() => _FindNewsPageState();
}

class _FindNewsPageState extends State<FindNewsPage> {
  final FindNewsImplementation post = new FindNewsImplementation();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //Функция вызывается при попытке обновить данные (refresh)
  Future<Null> _refresh() async {
    setState(() {});
    return;
  }

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text("Find News"),
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: FutureBuilder(
            future: post.postBuilder(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child: snapshot.data,
                );
              }else {
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