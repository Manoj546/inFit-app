import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:infit/pages/Home.dart';

import 'form.dart';

void main() => runApp(const VerifyEmail());

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();
    }

    timer = Timer.periodic(
      Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      var msg = e.message;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg.toString(),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red.shade500,
      ));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Home()
      : MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Email Verify Page",
          home: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(5),
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "inFit",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          //Image.asset('./assets/DSC04815.jpg'),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Verify Your email",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )),
          ));
}
