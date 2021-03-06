import 'package:flutter/material.dart';
import 'package:fwa_news/Widgets/DashboardPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fwa_news/Widgets/SettingsPage.dart';
import 'package:fwa_news/Widgets/MyPostPage.dart';
import 'package:fwa_news/Widgets/FindNewsPage.dart';

class Frame extends StatefulWidget {
  Frame({Key key}) : super(key: key);

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageViewIndexChange(index)
  {
    _selectedIndex = index;
    setState(() {});
  }

  void pageNavBarIndexChanged(index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: Container(
              child: PageView(
                controller: pageController,
                onPageChanged: pageViewIndexChange,
                children: <Widget>[
                  DashboardPage(),
                  MyPostPage(),
                  FindNewsPage(),
                  SettingsPage(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: <Widget>[
          Icon(Icons.apps, size: 30),
          Icon(Icons.account_box, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: pageNavBarIndexChanged,
        index: _selectedIndex,
        height: 50,
      ),
    );
  }
}
