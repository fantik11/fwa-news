import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostLoadInterface {
  Future<List<dynamic>> get _loadData async {}
  Future<Widget> postBuilder({int count = 20}) async {}
}

class PostCardWrapper extends StatefulWidget {
  final String id,
      sourceId,
      sourceName,
      author,
      title,
      url,
      urlToImage,
      publishedAt;
  Widget trailing;

  PostCardWrapper(
      {Key key,
      this.id,
      this.sourceId,
      this.sourceName,
      this.author,
      this.title,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.trailing})
      : super(key: key);

  @override
  _PostCardWrapperState createState() => _PostCardWrapperState();
}

_launchURL(String url) async {
  await launch(url);
}

class _PostCardWrapperState extends State<PostCardWrapper> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: "assets/images/image_placeholder.png",
                image: widget.urlToImage,
              ),
              onTap: () {
                _launchURL(widget.url);
              },
            )),
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
        trailing: widget.trailing,
        isThreeLine: true,
      ),
    );
  }
}
