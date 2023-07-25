import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/pallete.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        bottomNavigationBar: Container(
          color: Colors.white,
          child: _tabBar(),
        ),
        body: TabBarView(
          children: [
            // FrontPage(),
            // HistoryPage(),
            // ChatPage(),
            // FrontProfilePage()
          ],
        ),
      ),
    );
  }
}
_tabBar(){
  return TabBar(
    indicatorSize: TabBarIndicatorSize.label,
    indicatorColor: Palette.activeColor,
    indicatorWeight: 5,
    labelColor: Colors.black,
    tabs: [
      Tab(
        icon: Icon(
          size: 30,
          CupertinoIcons.home,
          color: Colors.black54,
        ),
        iconMargin: EdgeInsets.only(bottom: 10.0),
      ),
      Tab(
        icon: Icon(
          size: 30,
          Icons.assignment_outlined,
          color: Colors.black54,
        ),
        iconMargin: EdgeInsets.only(bottom: 10.0),
      ),
      Tab(
        icon: Icon(
          CupertinoIcons.chat_bubble_2,
          size: 30,
          color: Colors.black54,
        ),
        iconMargin: EdgeInsets.only(bottom: 10.0),
      ),
      Tab(
        icon: Icon(
          Icons.person_outline,
          size: 30,
          color: Colors.black54,
        ),
        iconMargin: EdgeInsets.only(bottom: 10.0),
      ),
    ],
  );
}