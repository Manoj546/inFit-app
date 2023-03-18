import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:infit/utils/constants.dart';

import 'icon_widget.dart';

Widget buildLogout() {
  return SimpleSettingsTile(
      title: 'Logout',
      subtitle: '',
      leading: const IconWidget( icon: Icons.logout , color: iconColor,),
      onTap: () {});
}
