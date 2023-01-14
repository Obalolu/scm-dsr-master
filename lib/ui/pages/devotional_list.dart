import 'package:devotional/db/database_helper.dart';
import 'package:devotional/models/devotional_model.dart';
import 'package:devotional/ui/widgets/devotional.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class DevotionalList extends StatefulWidget {
  final title;
  final index;

  const DevotionalList({Key key, this.title, this.index}) : super(key: key);

  @override
  _DevotionalListState createState() => _DevotionalListState();
}

class _DevotionalListState extends State<DevotionalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(child: allDevotionals(context)),
    );
  }

  Future<List<Devotional>> queryByMonth() async {
    return await DatabaseHelper.instance.queryByMonth(widget.index);
  }

  FutureBuilder<List<Devotional>> allDevotionals(BuildContext context) {
    return FutureBuilder<List<Devotional>>(
        future: queryByMonth(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          // Uncompleted State
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
              break;
            default:
            // Completed with error
              if (snapshot.hasError) {
                return Center(
                  child: EmptyWidget(
                    image: null,
                    packageImage: PackageImage.Image_1,
                    title: 'Something Went Wrong',
                    subTitle: 'Unable to get devotionals',
                    titleTextStyle: TextStyle(
                      fontSize: 22,
                      color: Color(0xff9da9c7),
                      fontWeight: FontWeight.w500,
                    ),
                    subtitleTextStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xffabb8d6),
                    ),
                  ),
                );;
              }
              List<Devotional> list = snapshot.data;
              print(list.length);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: list
                      .map(
                        (devotional) =>
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DevotionalWidget(
                                            title: 'Devotional',
                                            day: DateFormat("yyyy-MM-dd")
                                                .format(devotional.day),
                                          )));
                            });
                          },
                          child: Card(
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 16, top: 16, right: 16, bottom: 8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.blue[700],
                                      width: 2,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        offset: Offset(0, 1),
                                        blurRadius: 2)
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat.yMMMEd()
                                              .format(devotional.day),
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Inder',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Inder',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      devotional.topic,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inder',
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: Icon(Feather.book_open,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            devotional.bibleText,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'Inder',
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  )
                      .toList(),
                ),
              );
          }
        });
  }
}
