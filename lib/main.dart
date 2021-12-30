import 'package:devotional/ui/pages/home.dart';
import 'package:devotional/ui/pages/insert_devotionals.dart';
import 'package:devotional/ui/pages/login.dart';
import 'package:devotional/ui/pages/sign_up.dart';
import 'package:devotional/ui/widgets/rate_app_init_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>  MaterialApp(
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
      home: RateAppInitWidget(
        builder: (rateMyApp) => InsertDevotionals(rateMyApp: rateMyApp),
    )
  );
}
