import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fwa_news/preferences.dart';
import 'package:fwa_news/Routes/url.dart';
import 'package:sprintf/sprintf.dart';

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

  //Главный билдер
  Future<Widget> postBuilder({int count = 10}) async {
    List<dynamic> data = await _loadData();
    List<Widget> posts = new List<Widget>();

    data.asMap().forEach((i, element) {
      if (i < count) {
        //posts.add(PostCard.fromJson(element));
        posts.add(PostCard(
            id: element['id'],
            sourceId: element['sourceId'],
            sourceName: element['sourceName'],
            author: element['author'] == "" ? "Anonym" : element['author'],
            title: element['title'],
            url: element['url'],
            likes: element['likes'],
            urlToImage: element['urlToImage'],
            publishedAt: element['publishedAt']));
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

class PostMockup extends PostImplementation {
  Future<List<dynamic>> _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    String jsonned =
        '''[{"id":"8wCgtk5KDWALvHx1pi0stsEZjIkGwpOG0i2aIozqcYY","likes":0,"sourceId":"","sourceName":"Youtube.com","author":"","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""},{"id":"FoFb0NXx9NZUO0YT3JFFeUxrXAiV8NfKRPVATbM6UEA","likes":1,"sourceId":"","sourceName":"Youtube.com","author":"","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""},{"id":"xUkLTsGCUIRC7lO6YNYb8O-dqZjimipjiqv6IRk-kUs","likes":0,"sourceId":"","sourceName":"Youtube.com","author":"Alex","title":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","url":"Media boosts Pelosi while smearing GOP over impeachment - Fox News","urlToImage":"https://i.ytimg.com/vi/LngagxmhuoY/maxresdefault.jpg","publishedAt":""}]''';
    return jsonDecode(jsonned);
  }
}

class PostCard extends StatefulWidget {
  final String id,
      sourceId,
      sourceName,
      author,
      title,
      url,
      urlToImage,
      publishedAt;
  int likes;

  void changeLike(int newValue) {
    likes = newValue;
  }

  PostCard(
      {Key key,
      this.id,
      this.sourceId,
      this.sourceName,
      this.author,
      this.title,
      this.url,
      this.likes,
      this.urlToImage,
      this.publishedAt})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;

  @override
  void initState() {
    isLiked().then((value){
      setState(() {
        liked = value;
      });
    });
  }

  Future<Null> like() async {
    Map<String, String> headers = {
      "token": await SharedPreferencesHelper.getKeyValue("token"),
      "Content-Type": "application/json",
    };
    await http.post(sprintf(Url.LIKE_POST, [widget.id]), headers: headers);
    return;
  }

  Future<Null> unlike() async {
    Map<String, String> headers = {
      "token": await SharedPreferencesHelper.getKeyValue("token"),
      "Content-Type": "application/json",
    };
    await http.post(sprintf(Url.UNLIKE_POST, [widget.id]), headers: headers);
    return;
  }

  Future<bool> isLiked() async
  {
    Map<String, String> headers = {
      "token": await SharedPreferencesHelper.getKeyValue("token"),
      "Content-Type": "application/json",
    };
    http.Response httpResponse = await http.get(sprintf(Url.LIKE_GET, [widget.id]), headers: headers);
    return jsonDecode(httpResponse.body)["like"];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 80,
          width: 100,
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: "assets/images/image_placeholder.png",
            image: widget.urlToImage,
          ),
        ),
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.body2,
        ),
        subtitle: Text(
          "Posted by: " + widget.author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          children: <Widget>[
            Container(
              width: 25,
              height: 25,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.keyboard_arrow_up,
                    color: liked ? Colors.green : Colors.grey),
                onPressed: () {
                  setState(() {
                    //Добавить +1 лайк и послать запрос
                    if (liked == false) {
                      widget.changeLike(widget.likes + 1);
                      liked = true;
                      like();
                    } else {
                      widget.changeLike(widget.likes - 1);
                      liked = false;
                      unlike();
                    }
                  });
                },
              ),
            ),
            Text(
              widget.likes.toString(),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: liked ? Colors.green : Colors.grey),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
