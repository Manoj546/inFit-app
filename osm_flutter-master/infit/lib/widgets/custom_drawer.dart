import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/auth/google_sign_in.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Hey I am using INFIT App',
        text:
            'Hey I am usingINFIT App. It has best  workout  app for all age groups. You should try it once.',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  _fetchemail() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? email;
    if (currentUser != null) {
      email = currentUser.email;
    }
    print(email);
    return email;
  }

  _resetProgress() async {
    String email = _fetchemail();
    FirebaseFirestore.instance
        .collection('user_exercises').doc(email).collection("exercises").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80"))),
          ),
          // ListTile(
          //     title: Text(
          //       "Reset Progress",
          //       style: TextStyle(fontSize: 18),
          //     ),
          //     leading: Icon(
          //       Icons.restart_alt_sharp,
          //       size: 25,
          //     ),
          //     onTap: _resetProgress),
          ListTile(
            title: Text(
              "Share With Friends",
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.share,
              size: 25,
            ),
            onTap: shareApp,
          ),
          ListTile(
            title: Text(
              "Rate Us",
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.star,
              size: 25,
            ),
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://play.google.com/store/apps/details"));
            },
          ),
          ListTile(
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.security,
              size: 25,
            ),
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://sites.google.com/bmsce.ac.in/infitapp/home"));
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.SignOut();
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.sp,

              children: [
                Icon(
                  Icons.logout_outlined,
                  size: 28,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          Text(
            "Version 1.0.0",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
