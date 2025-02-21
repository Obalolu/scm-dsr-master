import 'dart:io';

import 'package:dsr/db/database_helper.dart';
import 'package:dsr/ui/pages/home_page.dart';
import 'package:dsr/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:sqflite/sqflite.dart';

import '../../api/api_service.dart';
import 'home.dart';

class InsertDevotionals extends StatefulWidget {
  final RateMyApp? rateMyApp;

  const InsertDevotionals({Key? key, this.rateMyApp}) : super(key: key);

  _InsertDevotionalsState createState() => _InsertDevotionalsState();
}

class _InsertDevotionalsState extends State<InsertDevotionals> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: addDevotional(context, widget.rateMyApp!),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.none:
            // TODO: Handle this case.
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            // TODO: Handle this case.
            break;
        }

        return snapshot.data!;
      },
    );
  }
}



Future<Widget> addDevotional(BuildContext context, RateMyApp rateMyApp) async {
  Database? db = await DatabaseHelper.instance.database;
  int? count = await DatabaseHelper.instance.isDatabaseNull();
  if (db != null && count == 0) {
    print('isFutureBuilder: ${true}');
    return LoginPage();
  } else {
    print('isFutureBuilder: ${false}');
    return Home();
  }
}

