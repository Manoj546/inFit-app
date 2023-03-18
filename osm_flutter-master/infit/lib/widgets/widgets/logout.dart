import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:infit/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../pages/auth/google_sign_in.dart';
import '../../pages/auth/login.dart';
import 'icon_widget.dart';

Widget buildLogout(BuildContext context) {
  return SimpleSettingsTile(
    title: 'Logout',
    subtitle: '',
    leading: const IconWidget(
      icon: Icons.logout,
      color: iconColor,
    ),
    onTap: () {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.SignOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    },
  );
}
