import 'package:devotional/db/database_helper.dart';
import 'package:devotional/ui/pages/about_page.dart';
import 'package:devotional/ui/pages/login.dart';
import 'package:devotional/ui/pages/reminder_page.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:settings_ui/settings_ui.dart';

class More extends StatefulWidget {

  final RateMyApp rateMyApp;

  const More({@required this.rateMyApp});

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {

  Future<Map<String, dynamic>> queryUser() async {
    var user = await DatabaseHelper.instance.queryUser();
    return user[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: queryUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.none:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  break;
              }

              final user = snapshot.data;
              // String initials = user['username'][0].toUpperCase();
              // String username = user['username'];
              // String email = user['email'];
              // int reminder = user['reminder'];
              // int reminderTime = user['reminderTime'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 64),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 80,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[700],
                      child: Text(
                        'U',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'User',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  // Text(
                  //   email,
                  //   style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.normal
                  //   ),
                  // ),
                  SizedBox(height: 24),
                  Expanded(
                    child: SettingsList(
                      backgroundColor: Colors.transparent,
                      sections: [
                        SettingsSection(
                          title: 'Reminder',
                          tiles: [
                            SettingsTile(
                              title: 'Reminder',
                              subtitle: 'Set a reminder to read your devotional',
                              leading: Icon(Icons.notifications_none),
                              onPressed: (BuildContext context) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        ReminderPage()));
                              },
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'Rate',
                          tiles: [
                            SettingsTile(
                              title: 'Rate This App',
                              subtitle: 'If you like this app, please leave us a rating',
                              leading: Icon(Icons.notifications_none),
                              onPressed: (BuildContext context) {
                                widget.rateMyApp.showStarRateDialog(
                                  context,
                                  title: 'Rate This App',
                                  message: 'Do you like this app? Please leave a rating',
                                  starRatingOptions: StarRatingOptions(initialRating: 4),
                                  actionsBuilder: actionsBuilder,
                                );
                              },
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'About',
                          tiles: [
                            SettingsTile(
                              title: 'About',
                              leading: Icon(Icons.info_outline),
                              onPressed: (BuildContext context) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AboutPage()));
                              },
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'Logout',
                          tiles: [
                            SettingsTile(
                              title: 'Logout',
                              leading: Icon(Icons.account_circle),
                              onPressed: (BuildContext context) async {
                                bool databaseDeleted = await DatabaseHelper
                                    .instance.deleteDb();
                                if (databaseDeleted) {
                                  Navigator.of(context).pop();
                                  Navigator.push(context, MaterialPageRoute(
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
            },
          ),

        ),
      ),
    );
  }

  List<Widget> actionsBuilder(BuildContext context, double stars) {
    return stars == null ? [buildCancelButton()] : [buildOkButton(), buildCancelButton()];
  }

  Widget buildCancelButton() {
    return RateMyAppNoButton(
      widget.rateMyApp,
      text: 'CANCEL',
    );
  }

  Widget buildOkButton() {
    return RateMyAppRateButton(
      widget.rateMyApp,
      text: 'OK',
    );
  }
}
