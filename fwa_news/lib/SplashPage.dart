import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'preferences.dart';
import 'dart:async';
class SplashPage extends StatelessWidget {
  Future _navigateToNextPage(context) async {
    String _haveToken = await SharedPreferencesHelper.getKeyValue("token");
    if(_haveToken == "")
    {
      Navigator.of(context).pushReplacementNamed('/login');
    }else
    {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
    
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => _navigateToNextPage(context));
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Flutter Wave Academy\r\n-\r\nNews",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SpinKitWave(
                color: Colors.lightBlue,
                size: 50.0,
              ),
              Text(
                "©fantik",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}