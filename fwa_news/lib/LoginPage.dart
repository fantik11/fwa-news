import 'package:flutter/material.dart';
import 'package:fwa_news/Helpers/FlashHelper.dart';
import 'package:fwa_news/preferences.dart';
import 'package:fwa_news/Routes/Routes.dart';

class LoginPage extends StatelessWidget {

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_background.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Text(
                      "Авторизация",
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.pinkAccent[100],
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 270,
                    child: TextField(
                      onSubmitted: (value) async {
                        if(value.length > 0)
                        {
                          await SharedPreferencesHelper.setKeyValue("token", value);
                          Navigator.of(context).pushReplacementNamed(Routes.FRAME);
                        }else
                        {
                          FlashHelper.errorBar(context, message: "Length of token should not equal zero");
                        }
                      },
                      decoration: new InputDecoration(
                        labelText: "Enter your token",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
