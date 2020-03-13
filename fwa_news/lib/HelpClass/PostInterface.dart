import 'package:flutter/material.dart';

class PostLoadInterface {
  Future<List<dynamic>> _loadData() async {}
  Future<Widget> postBuilder({int count = 10}) async{}
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
      this.trailing
      })
      : super(key: key);

  @override
  _PostCardWrapperState createState() => _PostCardWrapperState();
}

class _PostCardWrapperState extends State<PostCardWrapper> {

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
        trailing: widget.trailing,
        isThreeLine: true,
      ),
    );
  }
}