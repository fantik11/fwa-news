import 'package:flutter/material.dart';
import 'package:fwa_news/Helpers/preferences.dart';
import 'package:fwa_news/Routes/Routes.dart';
import 'package:fwa_news/Helpers/FlashHelper.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _controller = new TextEditingController();


  @override
  void initState() {
    SharedPreferencesHelper.getKeyValue("news_count").then((value) {
      if (value != false) {
        _controller.text = value;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text("Settings"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await SharedPreferencesHelper.setKeyValue("token", "");
              Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          onSubmitted: (value) async {
            if (int.parse(value) > 0) {
              await SharedPreferencesHelper.setKeyValue("news_count", value);
            } else {
              FlashHelper.errorBar(context,
                  message: "You should enter value higer that zero");
            }
          },
          decoration: new InputDecoration(
            labelText: "Enter the number of posts",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
      ),
    );
  }
}
