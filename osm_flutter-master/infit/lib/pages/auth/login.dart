import 'package:provider/provider.dart';
import 'package:infit/pages/auth/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infit/pages/auth/sign_up.dart';
import 'package:infit/pages/auth/ForgetPassword.dart';

void main() => runApp(const LoginPage());

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login Page",
        home: Scaffold(
          body: MyStatefulWidget(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
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

  Future signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                //Image.asset('assets/DSC04815.jpg'),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? "Enter min 6 characters"
                        : null,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgetPassword()),
                );
              },
              child: const Text(
                "Forgot Password",
                style: TextStyle(fontSize: 15),
              )),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: signin
                // {
                //   print(emailController);
                //   print(passwordController);
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const Home()),
                //   );
                // }
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Don't have an account ?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text("Sign Up", style: TextStyle(fontSize: 20)),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(350, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    label: const Text(
                      "Google",
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   child: ElevatedButton.icon(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue,
              //       minimumSize: Size(350, 60),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //     ),
              //     label: const Text(
              //       "Phone No",
              //       style: TextStyle(fontSize: 20),
              //     ),
              //     icon: FaIcon(
              //       FontAwesomeIcons.phone,
              //       color: Colors.white,
              //     ),
              //     onPressed: () {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => const Home()),
              //       // );
              //     },
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
