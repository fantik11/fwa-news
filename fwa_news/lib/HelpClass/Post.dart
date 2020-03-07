import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fwa_news/preferences.dart';
import 'package:fwa_news/Routes/url.dart';

class PostImplementation {
  Future<List<dynamic>> _loadData() async {
    Map<String, String> headers = {
      "token": await SharedPreferencesHelper.getKeyValue("token"),
      "Content-Type": "application/json",
    };
    while (true) {
      try {
        http.Response httpResponse =
            await http.get(Url.NEWS_GET, headers: headers);
        return jsonDecode(httpResponse.body);
      } catch (Exception) {}
    }
  }

  Future<Widget> postBuilder({int count = 10}) async {
    List<dynamic> data = await _loadData();
    List<Post> posts = new List<Post>();

    data.asMap().forEach((i, element) {
      if (i < count) {
        posts.add(Post.fromJson(element));
      }
    });

    return new ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return posts[index].build(ctxt);
      },
    );
  }
}

class PostMockup extends PostImplementation {
  Future<List<dynamic>> _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    String jsonned =
        '''[{"id":"8wCgtk5KDWALvHx1pi0stsEZjIkGwpOG0i2aIozqcYY","likes":0,"sourceId":"","sourceName":"Youtube.com","author":"","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""},{"id":"FoFb0NXx9NZUO0YT3JFFeUxrXAiV8NfKRPVATbM6UEA","likes":1,"sourceId":"","sourceName":"Youtube.com","author":"","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""},{"id":"xUkLTsGCUIRC7lO6YNYb8O-dqZjimipjiqv6IRk-kUs","likes":0,"sourceId":"","sourceName":"Youtube.com","author":"Alex","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""}]''';
    return jsonDecode(jsonned);
  }
}

class Post {
  final String id,
      sourceId,
      sourceName,
      author,
      title,
      url,
      urlToImage,
      publishedAt;

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sourceId = json['sourceId'],
        sourceName = json['sourceName'],
        author = json['author'],
        title = json['title'],
        url = json['url'],
        urlToImage = json['urlToImage'],
        publishedAt = json['publishedAt'];
  /*
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.black45))),
      child: Row(
        children: <Widget>[
          Container(
            height: 80,
            width: 100,
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: "assets/images/image_placeholder.png",
              image: urlToImage,
            ),
          ),
          Container(
            width: 300,
            padding: EdgeInsets.only(left: 8),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.body2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  */

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 80,
          width: 100,
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: "assets/images/image_placeholder.png",
            image: urlToImage,
          ),
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.body2,
        ),
        subtitle: Text(""),
        isThreeLine: true,
      ),
    );
  }
}
