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
      initialValue: 'Working 👩🏻‍💻 ',
      onChange: (status) {},
    ),
  );
}

Widget buildAbout() {
  return TextInputSettingsTile(
    title: 'About',
    settingKey: keyAbout,
    initialValue: 'Hi, I am manoj from india.',
    onChange: (about) {},
  );
}
