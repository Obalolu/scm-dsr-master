import 'package:dsr/api/notifications.dart';
import 'package:dsr/db/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'about_page.dart';

class ReminderPage extends StatefulWidget {

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remider'),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text('Remind'),
            onPressed: () {
              // NotificationApi.showNotification(title: 'Sarah Abs', body: 'How are you doing?', payload: 'sarah.abs');
            },
          ),
        ),
      ),
    );
  }
}
