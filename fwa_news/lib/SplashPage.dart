import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'preferences.dart';
import 'dart:async';
import 'Routes/Routes.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {

  @protected
  @mustCallSuper
  void initState() {
    Timer(Duration(seconds: 3), () => _navigateToNextPage(context));
  }

  Future _navigateToNextPage(context) async {
    String _haveToken = await SharedPreferencesHelper.getKeyValue("token");
    if (_haveToken == "") {
      Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.FRAME);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  children: <Widget>[
                    Text(
                      "Flutter Wave Academy",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "-",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "News",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              SpinKitWave(
                color: Colors.lightBlue,
                size: 50.0,
              ),
              Text(
                "©fantik",
                style: Theme.of(context).textTheme.overline
              ),
            ],
          ),
        ),
      ),
    );
  }
}