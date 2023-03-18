import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:infit/screens/account_page.dart';
import 'package:infit/screens/header_page.dart';
import 'package:infit/utils/constants.dart';
import 'package:infit/widgets/widgets/darkMode.dart';
import 'package:infit/widgets/widgets/delete.dart';
import 'package:infit/widgets/widgets/feedback.dart';
import 'package:infit/widgets/widgets/logout.dart';
import 'package:infit/widgets/widgets/reportbug.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topAppBar,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(padding),
            children: [
              HeaderPage(),
              const SizedBox(
                height: 16,
              ),
              SettingsGroup(title: 'General Settings', children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                AccountPage(),
                const SizedBox(
                  height: 16,
                ),
                buildLogout(context),
                const SizedBox(
                  height: 16,
                ),
                buildDeleteAccount(context),
                const SizedBox(
                  height: 16,
                ),
                // buildReportBug(context),
                // const SizedBox(
                //   height: 16,
                // ),
                // buildSendFeedback(context),
              ]),
            ],
          ),
        ));
  }
}

//Creating AppBar function
final topAppBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Padding(
    padding: EdgeInsets.only(left: 0, bottom: 20, right: 0, top: 30),
    child: Text(
      "Settings",
      style: TextStyle(
          letterSpacing: 2,
          color: colorSchema,
          fontSize: 30,
          fontWeight: FontWeight.bold),
    ),
  ),
  leading: const BackButton(color: colorSchema),
);
