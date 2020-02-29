import 'package:flutter/material.dart';
import 'preferences.dart';
import 'Routes/Routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("DashboardPage"),
            FutureBuilder(
              future: SharedPreferencesHelper.getKeyValue("token"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.done)
                {
                  return Text("Login is "+snapshot.data);
                }else
                {
                  return SpinKitWave(
                    color: Colors.lightBlue,
                    size: 50.0,
                  );
                }
              },
            ),
          ],
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
