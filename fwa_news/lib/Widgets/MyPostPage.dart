import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fwa_news/HelpClass/MyPostImplementation.dart';

class MyPostPage extends StatefulWidget {
  MyPostPage({Key key}) : super(key: key);
  @override
  _MyPostPageState createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  MyPostImplementation post = new MyPostImplementation();
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  void callback()
  {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text("My Posts"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: post.postBuilder(count: -1, fn:callback),
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
