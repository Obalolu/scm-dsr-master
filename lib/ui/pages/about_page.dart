// A simple page to talk about scm dsr: Low priority
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String text = '''There are currently 3.5 billion smartphone users worldwide (Statista, 2019). This number is also rising rapidly with time, with the increase Smartphone users the future of printing is fading away.

The Student Christian Movement of Nigeria being student and youth focused movement having observed the trend has developed the Mobile App version of the Daily Scripture Reading DSR.  

This App (Prototype) was developed by our students and come December they will be camping at the HQ working towards the launching of the DSR App for 2021. 

We appeal for your support in making this project a reality. 

The contributions should be paid into the Student Christian Movement project account, 
1014582018 
Zenith Bank.

God bless you!!!''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'SUPPORT THE DIGITAL DSR PROJECT',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20,),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}