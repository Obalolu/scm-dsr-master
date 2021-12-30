import 'dart:convert';

import 'package:devotional/db/database_helper.dart';
import 'package:devotional/models/devotional_model.dart';
import 'package:devotional/ui/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BibleStudyPage extends StatefulWidget {
  BibleStudyPage({this.id});

  final id;

  @override
  _BibleStudyPageState createState() => _BibleStudyPageState();
}

class _BibleStudyPageState extends State<BibleStudyPage> {
  Future<BibleStudy> queryMonth() async {
    final monthList = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    int month = widget.id == null ? DateTime.now().month - 1 : widget.id - 1;
    List<Map> result =
        await DatabaseHelper.instance.queryBibleStudy(monthList[month]);
    Map map = result[0];

    List list = jsonDecode(map['bibleTextList']);
    List<Bibletext> bibleText = [];
    list.forEach((element) {
      bibleText.add(Bibletext.fromJson(element));
    });

    return new BibleStudy(
      id: map[DatabaseHelper.bibleStudyId],
      topic: map[DatabaseHelper.bibleStudyTopic],
      bibleText: map[DatabaseHelper.bibleStudyBibleText],
      introduction: map[DatabaseHelper.bibleStudyIntroduction],
      discussion: map[DatabaseHelper.bibleStudyDiscussion],
      conclusion: map[DatabaseHelper.bibleStudyConclusion],
      month: map[DatabaseHelper.bibleStudyMonth],
      devotionalYear: map[DatabaseHelper.bibleStudyDevotionalYear],
      publishedAt: map[DatabaseHelper.bibleStudyPublishedAt],
      createdAt: map[DatabaseHelper.bibleStudyCreatedAt],
      updatedAt: map[DatabaseHelper.bibleStudyUpdatedAt],
      content: map[DatabaseHelper.bibleStudyContent],
      memoryVerse: map[DatabaseHelper.bibleStudyMemoryVerse],
      bibletext: bibleText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: queryMonth(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              // Uncompleted State
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                // Completed with error
                BibleStudy data = snapshot.data;
//                print(data.month);

                if (snapshot.hasError) {
                  return Container(child: Text(snapshot.error.toString()));
                } else {
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
                            'Bible Study',
                            style: TextStyle(fontFamily: 'Inder'),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Container(
                              color: Colors.blue[700],
                              padding: const EdgeInsets.only(
                                  left: 16, right: 8.0, top: 64, bottom: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(children: [
                                    Icon(
                                      MaterialIcons.today,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      data.month,
                                      style: TextStyle(
                                        fontFamily: 'Inder',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        height: 1.125,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ]),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 48),
                                      child: Text(
                                        data.topic,
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
                                    child: MaterialButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                            bibleTexts: data.bibletext,
                                          ),
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Feather.book_open,
                                                color: Colors.blue[700]),
                                            SizedBox(width: 6),
                                            Text(
                                              'Read  ${data.bibleText}',
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
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1000,
                          padding: const EdgeInsets.all(20.0),
                          child: MarkdownBody(
                            data:
                                '### Memory Verse\n${data.memoryVerse}\n${data.content}',
                            selectable: true,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                height: 1.5,
                              ),
                              h1: TextStyle(
                                height: 2.5,
                              ),
                              h3: TextStyle(
                                height: 2,
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ),
                  );
                }
            }
          }),
    );
  }

  Widget item(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontFamily: 'Inder', fontSize: 18),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.left,
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
}
