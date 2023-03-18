import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:infit/pages/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infit/pages/auth/phone.dart';

import 'form.dart';

void main() => runApp(const SignUpPage());

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future signup() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      var msg = e.message;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg.toString(),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red.shade500,
      ));
      //errors.showSnackBar(e.message);
    }
  }

  // void signUpUser() async {
  //   FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
  //         email: emailController.text,
  //         password: passwordController.text,
  //         context: context,
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sign Up Page",
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
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Form(
                      key: formKey,
                      child: Column(children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? "Enter a valid mail"
                                    : null,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: passwordController,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.done,
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                              suffix: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? "Enter min 6 characters"
                                    : null,
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.all(10),
                        //   child: TextFormField(
                        //     cursorColor: Colors.black,
                        //     textInputAction: TextInputAction.done,
                        //     obscureText: _isHidden,
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       hintText: 'Confirm Password',
                        //       suffix: InkWell(
                        //         onTap: _togglePasswordView,
                        //         child: Icon(Icons.visibility),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ])),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            signup();
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account ?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Sign In",
                            style: TextStyle(fontSize: 20)),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}
