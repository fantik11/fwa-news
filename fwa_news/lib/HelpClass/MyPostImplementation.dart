import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fwa_news/preferences.dart';
import 'package:fwa_news/Routes/url.dart';
import 'package:sprintf/sprintf.dart';
import 'package:fwa_news/HelpClass/PostInterface.dart';
import 'package:fwa_news/HelpClass/EditPageArguments.dart';
import 'package:fwa_news/Routes/Routes.dart';

class MyPostImplementation implements PostLoadInterface {
  Future<List<dynamic>> _loadData() async {
    Map<String, String> headers = {
      "token": await SharedPreferencesHelper.getKeyValue("token"),
      "Content-Type": "application/json",
    };
    while (true) {
      try {
        http.Response httpResponse =
            await http.get(Url.GET_MY_POSTS, headers: headers);
        return jsonDecode(httpResponse.body);
      } catch (Exception) {}
    }
  }

  //Главный билдер
  Future<Widget> postBuilder({int count = 20, Function fn}) async {
    List<dynamic> data = await _loadData();
    List<Widget> posts = new List<Widget>();

    data.asMap().forEach((i, element) {
      if (i != count) {
        //posts.add(PostCard.fromJson(element));
        posts.add(NewsCard(
            id: element['id'],
            sourceId: element['sourceId'],
            sourceName: element['sourceName'],
            author: element['author'] == "" ? "Anonym" : element['author'],
            title: element['title'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            publishedAt: element['publishedAt'],
            callback: fn));
      }
    });

    return new ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return posts[index];
      },
    );
  }
}

class PostMockup extends MyPostImplementation {
  Future<List<dynamic>> _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    String jsonned =
        '''[{"id":"8wCgtk5KDWALvHx1pi0stsEZjIkGwpOG0i2aIozqcYY","likes":0,"sourceId":"","sourceName":"Youtube.com","author":"","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""},{"id":"FoFb0NXx9NZUO0YT3JFFeUxrXAiV8NfKRPVATbM6UEA","likes":1,"sourceId":"","sourceName":"Youtube.com","author":"","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""},{"id":"xUkLTsGCUIRC7lO6YNYb8O-dqZjimipjiqv6IRk-kUs","likes":0,"sourceId":"","sourceName":"Youtube.com","author":"Alex","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""}]''';
    return jsonDecode(jsonned);
  }
}

class NewsCard extends StatefulWidget {
  final String id,
      sourceId,
      sourceName,
      author,
      title,
      url,
      urlToImage,
      publishedAt;
  final Function callback;

  NewsCard(
      {Key key,
      this.id,
      this.sourceId,
      this.sourceName,
      this.author,
      this.title,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.callback})
      : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  Future<Null> delete() async {
    Map<String, String> headers = {
      "token": await SharedPreferencesHelper.getKeyValue("token"),
      "Content-Type": "application/json",
    };
    await http.delete(sprintf(Url.DELETE_POST, [widget.id]), headers: headers);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PostCardWrapper(
        id: widget.id,
        sourceId: widget.sourceId,
        sourceName: widget.sourceName,
        author: widget.author == "" ? "Anonym" : widget.author,
        title: widget.title,
        url: widget.url,
        urlToImage: widget.urlToImage,
        publishedAt: widget.publishedAt,
        trailing: Container(
            width: 25,
            height: 55,
            child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async{
                  await delete();
                  widget.callback();
                })),
      ),
      onLongPress: () {
        Navigator.pushNamed(context, Routes.EDIT_POST,
            arguments: EditPageArguments(widget.urlToImage, widget.title,
                widget.url, widget.sourceName, widget.id));
      },
    );
  }
}
