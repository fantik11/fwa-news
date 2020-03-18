import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fwa_news/HelpClass/PostInterface.dart';
import 'package:fwa_news/HelpClass/EditPageArguments.dart';
import 'package:fwa_news/Routes/Routes.dart';
import 'package:fwa_news/Routes/Url.dart';
import 'package:sprintf/sprintf.dart';
import 'package:fwa_news/settings.dart';
import 'dart:developer';

class FindNewsImplementation implements PostLoadInterface {
  Future<List<dynamic>> _loadData() async {
    http.Response httpResponse =
        await http.get(sprintf(Url.FIND_NEWS_URL, [Settings.NEWS_API_KEY]));
    return jsonDecode(httpResponse.body)["articles"];
  }

  //Главный билдер
  Future<Widget> postBuilder({int count = 20}) async {
    List<dynamic> data = await _loadData();

    List<Widget> posts = new List<Widget>();

    data.asMap().forEach((i, element) {
      if (i != count) {
        //posts.add(PostCard.fromJson(element));
        posts.add(FindNewsCard(
            id: "",
            sourceId: element["source"]['sourceId'],
            sourceName: element["source"]['sourceName'],
            author: element['author'] == "" ? "Anonym" : element['author'],
            title: element['title'],
            url: element['url'],
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

class FindNewsMockup extends FindNewsImplementation {
  Future<List<dynamic>> _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    String jsonned =
        '''{"status":"ok","totalResults":5017,"articles":[{"source":{"id":"techcrunch","name":"TechCrunch"},"author":"Romain Dillet","title":"Bitcoin is also having a very, very bad day","description":"Bitcoin is going through a remarkably bad day. It turns out all assets are having a rough month — including cryptocurrencies. A couple of hours ago, the average price of BTC dropped by 15% in just 20 minutes. On CoinGecko, 1 BTC was worth around 7,250 across…","url":"http://techcrunch.com/2020/03/12/bitcoin-is-also-having-a-very-very-bad-day/","urlToImage":"https://techcrunch.com/wp-content/uploads/2019/04/bitcoin-bitfinex.jpg?w=750","publishedAt":"2020-03-12T12:34:45Z","content":"Bitcoin is going through a remarkably bad day. It turns out all assets are having a rough month including cryptocurrencies. A couple of hours ago, the average price of BTC dropped by 15% in just 20 minutes.On CoinGecko, 1 BTC was worth around 7,250 across … [+1146 chars]"},{"source":{"id":"mashable","name":"Mashable"},"author":"Stan Schroeder","title":"HTC's Exodus 5G router can be a Bitcoin node","description":"After launching two cryptocurrency-oriented smartphones, the HTC Exodus 1 and the Exodus 1s, the company is expanding the lineup with an entirely new device: a 5G router that can function as a full Bitcoin node. Called the HTC Exodus 5G hub, the Android-based…","url":"https://mashable.com/article/htc-exodus-5g-hub/","urlToImage":"https://mondrian.mashable.com/2020%252F03%252F04%252F22%252Fe8359029a8744acb93599edc973a0d95.7928e.jpg%252F1200x630.jpg?signature=b9tTdqwOKyi9aHqSL-KIA6J_RwY=","publishedAt":"2020-03-04T13:00:00Z","content":"After launching two cryptocurrency-oriented smartphones, the HTC Exodus 1 and the Exodus 1s, the company is expanding the lineup with an entirely new device: a 5G router that can function as a full Bitcoin node. Called the HTC Exodus 5G hub, the Android-bas… [+2230 chars]"},{"source":{"id":"techcrunch","name":"TechCrunch"},"author":"Romain Dillet","title":"DeFi aims to bridge the gap between blockchains and financial services","description":"If you’ve been following cryptocurrency news for the past few months, there’s one word that keeps coming back — DeFi, also known as decentralized finance. As the name suggests, DeFi aims to bridge the gap between decentralized blockchains and financial servic…","url":"http://techcrunch.com/2020/02/20/defi-aims-to-bridge-the-gap-between-blockchains-and-financial-services/","urlToImage":"https://techcrunch.com/wp-content/uploads/2020/02/dmitry-demidko-z4VuRg-ZOEg-unsplash.jpg?w=600","publishedAt":"2020-02-20T19:18:20Z","content":"If youve been following cryptocurrency news for the past few months, theres one word that keeps coming back DeFi, also known as decentralized finance. As the name suggests, DeFi aims to bridge the gap between decentralized blockchains and financial services.… [+983 chars]"},{"source":{"id":"techcrunch","name":"TechCrunch"},"author":"Manish Singh","title":"India lifts ban on cryptocurrency trading","description":"India’s Supreme Court on Wednesday struck down central bank’s two-year-old ban on cryptocurrency trading in the country in what many said was a “historic” verdict. The Reserve Bank of India had imposed a ban on cryptocurrency trading in April 2018 that barred…","url":"http://techcrunch.com/2020/03/03/india-lifts-ban-on-cryptocurrency-trading/","urlToImage":"https://techcrunch.com/wp-content/uploads/2020/03/GettyImages-1174941001.jpg?w=600","publishedAt":"2020-03-04T06:19:08Z","content":"Indias Supreme Court on Wednesday overturned central banks two-year-old ban on cryptocurrency trading in the country in what many said was a historic verdict.The Reserve Bank of India had imposed a ban on cryptocurrency trading in April 2018 that barred ban… [+1336 chars]"},{"source":{"id":null,"name":"Slashdot.org"},"author":"BeauHD","title":"The Countdown To Bitcoin Halving 2020 Begins","description":"Ali Raza from InsideBitcoins discusses the expected Bitcoin Halving in May 2020, and the impact it will have on the market valuation. From the report: The next Bitcoin Halving will take place on May 20th 2020. It will be the third time, that the block reward …","url":"https://news.slashdot.org/story/20/02/17/231219/the-countdown-to-bitcoin-halving-2020-begins","urlToImage":"https://a.fsdn.com/sd/topics/bitcoin_64.png","publishedAt":"2020-02-18T00:50:00Z","content":"The next Bitcoin Halving will take place on May 20th 2020. It will be the third time, that the block reward of the most known blockchain will be halved. As a consequence, miners will earn 50 percent less BTC for every generated block. Experts are expecting, t… [+922 chars]"}]}''';
    return jsonDecode(jsonned)["articles"];
  }
}

class FindNewsCard extends StatefulWidget {
  final String id,
      sourceId,
      sourceName,
      author,
      title,
      url,
      urlToImage,
      publishedAt;
  final Function callback;

  FindNewsCard(
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
  _FindNewsCardState createState() => _FindNewsCardState();
}

class _FindNewsCardState extends State<FindNewsCard> {
  @override
  Widget build(BuildContext context) {
    return PostCardWrapper(
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
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, Routes.EDIT_POST,
                arguments: EditPageArguments(widget.urlToImage, widget.title,
                    widget.url, widget.sourceName, widget.id));
          },
        ),
      ),
    );
  }
}
