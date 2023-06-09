import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:infit/utils/constants.dart';
import 'package:infit/widgets/widgets/account_info.dart';
import 'package:infit/widgets/widgets/icon_widget.dart';
import 'package:infit/widgets/widgets/language.dart';
import 'package:infit/widgets/widgets/location.dart';
import 'package:infit/widgets/widgets/privacy.dart';
import 'package:infit/widgets/widgets/security.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Account Settings',
      subtitle: 'Privacy, Security, Language',
      leading: const IconWidget(
        icon: Icons.person,
        color: iconColor,
      ),
      child: SettingsScreen(
        title: 'Account Settings',
        children: <Widget>[
          buildLanguage(),
          const SizedBox(
            height: 16,
          ),
          // buildLocation(),
          const SizedBox(
            height: 16,
          ),
          // buildPrivacy(context),
          const SizedBox(
            height: 16,
          ),
          buildSecurity(context),
          const SizedBox(
            height: 16,
          ),
          buildAccountInfo(context),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
