import 'package:carousel_slider/carousel_slider.dart';
import 'package:dsr/db/database_helper.dart';
import 'package:dsr/ui/pages/bible_study_page.dart';
import 'package:dsr/ui/widgets/devotional.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:new_version/new_version.dart';

import 'all_devotionals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();

    // _checkVersion();
  }

  // void _checkVersion() async{
  //   final newVersion = NewVersion(
  //     androidId: 'com.scm_dsr.devotional',
  //       context: context,
  //   );
  //   newVersion.showAlertIfNecessary();
  // }

  Future<String> queryUsername() async {
    var user = await DatabaseHelper.instance.queryUser();
    return user[0]['username'];
  }

  Future<List<Map<String, dynamic>>> queryDays() async {
    return await DatabaseHelper.instance.queryDevotionalCarousel();
  }

  Future<List<Map<String, dynamic>>> queryBibleStudy() async {
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

    return await DatabaseHelper.instance
        .queryBibleStudy(monthList[DateTime.now().month - 1]);
  }

  Future<List<Map<String, dynamic>>> queryReflection() async {
    return await DatabaseHelper.instance
        .queryReflection(newFormat.format(DateTime.now()));
  }

  Widget devotionalCarousel(int index, List item) {
    String dayText = '';
    Color backgroundColor = Colors.white;
    Color primaryColor = Colors.black;
    Color secondaryColor = Colors.black54;

    if (item[index]['Day'] == newFormat.format(DateTime.now())) {
      dayText = 'TODAY';
      backgroundColor = Colors.blue[700]!;
      primaryColor = Colors.white;
      secondaryColor = Colors.white.withValues(alpha: (0.9 * 255).toDouble());
    } else if (item[index]['Day'] ==
        newFormat.format(DateTime.now().subtract(Duration(days: 1)))) {
      dayText = 'YESTERDAY';
    } else if (item[index]['Day'] ==
        newFormat.format(DateTime.now().add(Duration(days: 1)))) {
      dayText = 'TOMORROW';
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 1),
              blurRadius: 2)
        ],
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMEd().format(DateTime.parse(item[index]['Day'])),
                style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'Inder',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                dayText,
                style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'Inder',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            item[index]['topic'],
            maxLines: 2,
            semanticsLabel: "...",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'Inder',
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 0, child: Icon(Icons.menu_book, color: secondaryColor)),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Text(
                  item[index]['bibleText'],
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    color: secondaryColor,
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
    );
  }

  Widget bibleStudyCarousel(Map<String, dynamic> item) {
    String monthText = item['month'];
    String topic = item['topic'];
    String bibleText = item['bibleText'];
    Color backgroundColor = Colors.white;
    Color primaryColor = Colors.grey[900]!;
    Color secondaryColor =
        Colors.grey[700]!.withValues(alpha: (0.9 * 255).toDouble());

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 1),
              blurRadius: 2)
        ],
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthText.toUpperCase(),
                style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'Inder',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Bible Study'.toUpperCase(),
                style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'Inder',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            topic,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'Inder',
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  flex: 0, child: Icon(Icons.menu_book, color: secondaryColor)),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Text(
                  bibleText,
                  style: TextStyle(
                    color: secondaryColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: queryUsername(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  break;
              }

              String? username = snapshot.data;

              String greeting() {
                var hour = DateTime.now().hour;
                if (hour < 12) {
                  return 'Good Morning';
                }
                if (hour < 17) {
                  return 'Good Afternoon';
                }
                return 'Good Evening';
              }

              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.yellow.shade600,
                          size: 36,
                        ),
                        SizedBox(width: 8),
                        Text(
                          (username != null)
                              ? '${greeting()} $username'
                              : '${greeting()}',
                          style: TextStyle(
                            fontFamily: 'Inder',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Devotional',
                      style: TextStyle(
                        fontFamily: 'Inder',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder(
                      future: queryDays(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                                color: Colors.grey[200],
                                height: 230,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          case ConnectionState.none:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            break;
                        }
                        List<Map<String, dynamic>>? item = snapshot.data;

                        if (item != null) {
                          if (item.isEmpty) {
                            print('Empty');
                          }
                          return Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: item.length,
                                options: CarouselOptions(
                                  viewportFraction: 0.8,
                                  initialPage: item.indexWhere((element) =>
                                      element['Day'] ==
                                      newFormat.format(DateTime.now())),
                                  aspectRatio: 6.5 / 3,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DevotionalWidget(
                                                        title: 'Devotional',
                                                        day: item[index]['Day'],
                                                      )));
                                        });
                                      },
                                      child: devotionalCarousel(index, item),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllDevotionals()));
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'See all devotionals',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blue[700],
                                        fontFamily: 'Inder',
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward,
                                        color: Colors.blue[700]),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: 1,
                                options: CarouselOptions(
                                  viewportFraction: 0.8,
                                  aspectRatio: 6.5 / 3,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Card(
                                    child: Center(
                                      child: Text(
                                        'No Devotionals Available',
                                        style: TextStyle(
                                          fontFamily: 'Inder',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllDevotionals()));
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'See all devotionals',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blue[700],
                                        fontFamily: 'Inder',
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward,
                                        color: Colors.blue[700]),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Bible Study',
                      style: TextStyle(
                        fontFamily: 'Inder',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder(
                      future: queryBibleStudy(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                                color: Colors.grey[200],
                                height: 230,
                                child:
                                    Center(child: CircularProgressIndicator()));
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

                        List<Map<String, dynamic>>? item = snapshot.data;

                        if (item!.isNotEmpty) {
                          return Card(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BibleStudyPage()));
                                  });
                                },
                                child: bibleStudyCarousel(item[0])),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BibleStudyPage()));
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'No Bible Study Available',
                                      style: TextStyle(
                                        fontFamily: 'Inder',
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Reflection',
                      style: TextStyle(
                        fontFamily: 'Inder',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder(
                      future: queryReflection(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                                color: Colors.grey[200],
                                height: 230,
                                child:
                                    Center(child: CircularProgressIndicator()));
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

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Something went wrong',
                            ),
                          );
                        } else {
                          List<Map<String, dynamic>>? item = snapshot.data;

                          return Card(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DevotionalWidget()));
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  width: MediaQuery.of(context).size.width,
                                  constraints: BoxConstraints(
                                    minHeight: 200,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/resurrection.png',
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Color(0x90000000),
                                            BlendMode.darken)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (item!.isNotEmpty)
                                          ? item[0]['reflection']
                                          : 'No Reflection',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inder',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
