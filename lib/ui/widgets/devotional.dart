import 'dart:convert';

import 'package:dsr/db/database_helper.dart';
import 'package:dsr/models/devotional_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'custom_dialog.dart';

// TODO: Create Devotional Widget
class DevotionalWidget extends StatefulWidget {
  final title;
  final day;

  const DevotionalWidget({Key? key, this.title, this.day}) : super(key: key);

  @override
  _DevotionalWidgetState createState() => _DevotionalWidgetState();
}

class _DevotionalWidgetState extends State<DevotionalWidget> {
  Future<Devotional> _setData() async {
    Database? db = await DatabaseHelper.instance.database;

    var newFormat = DateFormat("yyyy-MM-dd");

    List<Map> result = await db!.query(DatabaseHelper.devotionalTable,
        columns: [
          DatabaseHelper.id,
          DatabaseHelper.topic,
          DatabaseHelper.bibletext,
          DatabaseHelper.bibleText,
          DatabaseHelper.content,
          DatabaseHelper.day,
          DatabaseHelper.prayer,
          DatabaseHelper.furtherReading,
          DatabaseHelper.reflection,
          DatabaseHelper.publishedAt
        ],
        where: '${DatabaseHelper.day} = ?',
        whereArgs: [
          widget.day == null ? newFormat.format(DateTime.now()) : widget.day
        ]);

    Map map = result[0];

    DateTime day = newFormat.parse(map['Day']);
    List list = jsonDecode(map['bibleTextList']);
    List<Bibletext> bibleText = [];
    list.forEach((element) {
      bibleText.add(Bibletext.fromJson(element)); // = ;
    });
//    = jsonDecode(map['bibleTextList']).map((text) {
//
//    }).toList();


    return new Devotional(
        id: map['id'],
        topic: map['topic'],
        bibleText: map['bibleText'],
        bibletext: bibleText,
        content: map['content'],
        day: day,
        prayer: map['prayer'],
        furtherReading: map['furtherReading'],
        reflection: map['reflection']);
  }

  FutureBuilder<Devotional> devotional() {
    return FutureBuilder(
        future: _setData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          // Uncompleted State
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
            // Completed with error

              if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong'),
                );
              } else {
                var dev = snapshot.data;
                String day = DateFormat.yMMMEd().format(dev!.day!);

                return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 350.0,
                          floating: true,
                          pinned: true,
                          snap: false,
                          title: Text(
                            widget.title == null
                                ? 'Today\'s Devotional'
                                : widget.title,
                            style: TextStyle(fontFamily: 'Inder'),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[700],
//                                  image: DecorationImage(
//                                      image: AssetImage(
//                                          'assets/images/banner.jpeg'),
//                                      fit: BoxFit.cover,
//                                      colorFilter: ColorFilter.mode(
//                                          Color(0x90000000),
//                                          BlendMode.darken)
//                                  )
                              ),
                              padding: const EdgeInsets.only(
                                  left: 16, right: 8.0, top: 64, bottom: 8),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.today,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      day,
                                      style: TextStyle(
                                        fontFamily: 'Inder',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        height: 1.125,
                                        color: Colors.white.withValues(alpha: (0.9 * 255).toDouble()),
                                      ),
                                    ),
                                  ]),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 48),
                                      child: Text(
                                        dev.topic!,
                                        style: TextStyle(
                                          fontFamily: 'Inder',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 28,
                                          height: 1.0833333333333333,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      dev.bibleText!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Inder',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          height: 1.125
                                      ),
                                    ),),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: MaterialButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                                bibleTexts: dev.bibletext,),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.menu_book,
                                                color: Colors.blue[700]),
                                            SizedBox(width: 6),
                                            Text(
                                              'Read',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.blue[700],
                                                  fontFamily: 'Inder',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.125),
                                            ),
                                            SizedBox(width: 6),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                dev.content!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'Inder',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    height: 1.7),
                              ),
                            ),
                            item(Icon(Icons.smart_display),
                                'Reflections', dev.reflection!),
                            item(Icon(Icons.menu_book), 'Further Reading',
                                dev.furtherReading!),
                            item(Icon(Icons.book), 'Prayer', dev.prayer!)
                          ],
                        ),
                      ),
                    ));
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Feather.check),
//        tooltip: 'Done Reading',
//        onPressed: () {
////            Navigator.pop(context);
//        },
//      ),
      body: SafeArea(
        child: devotional(),
      ),
    );
  }
}

Widget item(Icon icon, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
//            Icon(Feather.book, color: Colors.black,),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(fontFamily: 'Inder', fontSize: 18),
            ),
          ],
        ),
        Text(
          subtitle,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'Inder',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              height: 1.5),
        ),
      ],
    ),
  );
}
