import 'package:flutter/material.dart';

import '../screens/settings_page.dart';

class Custom_appbar extends StatelessWidget {
  AnimationController animationController;
  Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
  Function()? onPressed;

  Custom_appbar(
      {required this.animationController,
      required this.onPressed,
      required this.colorsTween,
      required this.homeTween,
      required this.yogaTween,
      required this.iconTween,
      required this.drawerTween});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: ((context, child) => AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.dehaze,
                  color: drawerTween.value,
                ),
                onPressed: onPressed,
              ),
              backgroundColor: colorsTween.value,
              elevation: 0,
              title: Row(children: [
                Text(
                  "in",
                  style: TextStyle(
                      color: homeTween.value,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Fit",
                  style: TextStyle(
                      color: yogaTween.value,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ]),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage()),
                    );
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: iconTween.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: iconTween.value,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
