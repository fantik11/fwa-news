import 'package:flutter/material.dart';
import 'preferences.dart';
import 'Routes/Routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'HelpClass/Post.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PostMockup post = new PostMockup();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

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
          future: post.postBuilder(),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.exit_to_app,
        ),
        onPressed: () async {
          await SharedPreferencesHelper.setKeyValue("token", "");
          Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
        },
      ),
      
    );
  }
}
