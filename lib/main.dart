import 'package:devotional/ui/pages/insert_devotionals.dart';
import 'package:devotional/ui/pages/payment_page.dart';
import 'package:devotional/ui/widgets/rate_app_init_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'ui/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Scripture Reading',
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: 'Inder', fontWeight: FontWeight.bold, fontSize: 30),
            headline2: TextStyle(fontFamily: 'Inder'),
            headline3: TextStyle(fontFamily: 'Inder'),
            headline4: TextStyle(fontFamily: 'Inder'),
            headline5: TextStyle(fontFamily: 'Inder'),
            headline6: TextStyle(fontFamily: 'Inder'),
            subtitle1: TextStyle(fontFamily: 'Inder'),
            subtitle2: TextStyle(fontFamily: 'Inder'),
            bodyText1: TextStyle(fontFamily: 'Inder'),
            bodyText2: TextStyle(fontFamily: 'Inder'),
            caption: TextStyle(fontFamily: 'Inder'),
            button: TextStyle(fontFamily: 'Inder'),
            overline: TextStyle(fontFamily: 'Inder'),
          ),
          primaryColor: Colors.blue[700],
        ),
        routes: <String, WidgetBuilder>{
          // '/': (BuildContext context) => PaymentPage(),
          '/': (BuildContext context) =>
              RateAppInitWidget(
                builder: (rateMyApp) => Home(rateMyApp: rateMyApp),
              ),
        },
      );

  void initDynamicLinks() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }

  }

}

