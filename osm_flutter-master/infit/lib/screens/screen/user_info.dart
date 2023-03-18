import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:infit/utils/constants.dart';

const keyStatus = 'key-status';
const keyAbout = 'key-about';

Widget buildStatus() {
  return Padding(
    padding: const EdgeInsets.only(bottom: userPadding),
    child: TextInputSettingsTile(
      title: 'Status',
      settingKey: keyStatus,
      initialValue: 'Full body workout ',
      onChange: (status) {},
    ),
  );
}

Widget buildAbout() {
  return TextInputSettingsTile(
    title: 'Timeline',
    settingKey: keyAbout,
    initialValue: 'Joined on 25th Dec',
    onChange: (about) {},
  );
}
