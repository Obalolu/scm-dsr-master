import 'package:dsr/db/database_helper.dart';
import 'package:dsr/providers/theme_provider.dart';
import 'package:dsr/ui/pages/about_page.dart';
import 'package:dsr/ui/pages/login.dart';
import 'package:dsr/ui/pages/reminder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../main.dart';

class More extends ConsumerWidget {
  const More();

  Future<Map<String, dynamic>> queryUser() async {
    var user = await DatabaseHelper.instance.queryUser();
    return user[0];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProv = ref.watch(themeProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: queryUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  // if (snapshot.hasError) {
                  //   return Center(child: Text('Error loading user data'));
                  // }
                  // Assuming the user data is available here
                  return _buildSettingsList(context, ref);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 64),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: CircleAvatar(
            backgroundColor: Colors.blue[700],
            child: Text(
              'U',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'User',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 24),
        Expanded(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text('Reminder'),
                tiles: [
                  SettingsTile(
                    title: Text('Reminder'),
                    description: Text('Set a reminder to read your devotional'),
                    leading: Icon(Icons.notifications_none),
                    onPressed: (BuildContext context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReminderPage()));
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Text('Theme'),
                tiles: [
                  SettingsTile(
                    title: Text('Light Theme'),
                    leading: Icon(Icons.wb_sunny),
                    onPressed: (context) => ref
                        .read(themeProvider.notifier)
                        .setThemeMode(ThemeMode.light),
                  ),
                  SettingsTile(
                    title: Text('Dark Theme'),
                    leading: Icon(Icons.nights_stay),
                    onPressed: (context) => ref
                        .read(themeProvider.notifier)
                        .setThemeMode(ThemeMode.dark),
                  ),
                  SettingsTile(
                    title: Text('System Default'),
                    leading: Icon(Icons.settings),
                    onPressed: (context) => ref
                        .read(themeProvider.notifier)
                        .setThemeMode(ThemeMode.system),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('About'),
                tiles: [
                  SettingsTile(
                    title: Text('About'),
                    leading: Icon(Icons.info_outline),
                    onPressed: (BuildContext context) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutPage()));
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Text('Logout'),
                tiles: [
                  SettingsTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.account_circle),
                    onPressed: (BuildContext context) async {
                      bool databaseDeleted =
                          await DatabaseHelper.instance.deleteDb();
                      if (databaseDeleted) {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
