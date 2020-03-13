import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fwa_news/preferences.dart';
import 'package:fwa_news/Routes/url.dart';
import 'dart:developer';

class EditPostPage extends StatefulWidget {
  String id, sourceName, title, url, urlToImage;
  bool isNew = true;
  EditPostPage(
      {Key key,
      this.id,
      this.sourceName,
      this.title,
      this.url,
      this.urlToImage,
      this.isNew})
      : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  TextEditingController imgUrlController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  TextEditingController sourceController = new TextEditingController();

  void onConfirm(BuildContext context) async {
    Map<String, String> headers = {
        "token": await SharedPreferencesHelper.getKeyValue("token"),
        "Content-Type": "application/json",
      };

      Map<String, String> body = {
        "id":"",
        "sourceId": null,
        "sourceName": sourceController.text,
        "author": await SharedPreferencesHelper.getKeyValue("token"),
        "title": titleController.text,
        "description": "",
        "url": urlController.text,
        "urlToImage": imgUrlController.text,
        "publishedAt": "2019-12-27T22:26:27Z"
      };

      http.Response response = await http.post(Url.NEW_POST,
          headers: headers, body: jsonEncode(body));
      log(response.body);
      //Navigator.pop(context);
      return;
      
  }

  @override
  void initState() {
    imgUrlController.text = widget.urlToImage;
    titleController.text = widget.title;
    urlController.text = widget.url;
    sourceController.text = widget.sourceName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text("Edit post"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  onConfirm(context);
                },
                child: Icon(Icons.check),
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  width: 120,
                  height: 80,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: "assets/images/image_placeholder.png",
                    image: widget.url == null ? "" : widget.url,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 250,
                  child: TextField(
                    controller: imgUrlController,
                    onSubmitted: (value) {
                      setState(() {
                        widget.url = value;
                      });
                    },
                    decoration: new InputDecoration(
                      labelText: "Enter url of image",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: titleController,
              decoration: new InputDecoration(
                labelText: "Enter title of post",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: urlController,
              decoration: new InputDecoration(
                labelText: "Enter url",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: sourceController,
              decoration: new InputDecoration(
                labelText: "Enter source",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
