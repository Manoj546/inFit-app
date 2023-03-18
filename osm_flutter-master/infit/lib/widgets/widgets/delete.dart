import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:infit/utils/constants.dart';

import '../../pages/auth/form.dart';
import 'icon_widget.dart';

Widget buildDeleteAccount(BuildContext context) {
  return SimpleSettingsTile(
    title: 'Enter data',
    subtitle: '',
    leading: const IconWidget(
      icon: Icons.data_exploration,
      color: iconColor,
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserForm()),
      );
    },
  );
}
