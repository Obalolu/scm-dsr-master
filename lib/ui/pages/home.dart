import 'package:devotional/ui/pages/all_devotionals.dart';
import 'package:devotional/ui/pages/insert_devotionals.dart';
import 'package:devotional/ui/pages/more.dart';
import 'package:devotional/ui/widgets/devotional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'bible_study_page.dart';
import 'home_page.dart';

class Home extends StatefulWidget {

  final RateMyApp rateMyApp;

  const Home({Key key, this.rateMyApp}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget currentScreen = HomePage(); // Our first view in viewport
  int currentTab = 0; // to keep track of active tab index

  final PageStorageBucket bucket = PageStorageBucket();

  Widget navTab(IconData icon, String text, Widget screen, int tab) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
        ),
        onPressed: () {
          setState(() {
            currentScreen =
                screen; // if user taps on this dashboard tab will be active
            currentTab = tab;
          });
        },
        child: Container(
          padding: EdgeInsets.all(8),
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: currentTab == tab ? Colors.blue[700] : Colors.black12,
                width: currentTab == tab ? 3 : 2,
              ),
            ),
          ),
          height: 60,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: currentTab == tab ? Colors.blue[700] : Colors.grey,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: currentTab == tab ? Colors.blue[700] : Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              navTab(
                  MaterialCommunityIcons.home_outline, 'Home', HomePage(), 0),
              navTab(MaterialCommunityIcons.book_outline, 'Today', DevotionalWidget(), 1),
              navTab(MaterialCommunityIcons.book_search_outline, 'All', AllDevotionals(), 2),
              navTab(MaterialCommunityIcons.menu, 'More', More(rateMyApp: widget.rateMyApp), 4),
            ],
          ),
        ),
      ),
    );
  }
}

