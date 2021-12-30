import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'devotional_list.dart';

class AllDevotionals extends StatefulWidget {
  @override
  _AllDevotionalsState createState() => _AllDevotionalsState();
}

class _AllDevotionalsState extends State<AllDevotionals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Devotionals')),
      body: expandableList(),
    );
  }

  Widget expandableList() {
    final headerList = [
      ['January', 0],
      ['February', 1],
      ['March', 2],
      ['April', 3],
      ['May', 4],
      ['June', 5],
      ['July', 6],
      ['August', 7],
      ['September', 8],
      ['October', 9],
      ['November', 10],
      ['December', 11]
    ];

    return ListView(
      children: headerList
          .map((item) => InkWell(
        onTap: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DevotionalList(title: item[0], index: item[1])));
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Text(item[0], style: TextStyle(fontSize: 18,),),
            ),
            Divider(height: 1,),
          ],
        ),
      ))
          .toList(),
    );
  }
}
