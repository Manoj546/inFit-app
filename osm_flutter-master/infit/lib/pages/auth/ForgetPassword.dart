import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(const ForgetPassword());

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Forget Password",
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

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  showsnackbar(String message, context) {
    final snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red.shade500,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showsnackbar("Forget password email sent", context);
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
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Forget Password",
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
              ],
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
                child: const Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: resetPassword),
          ),
        ],
      ),
    );
  }
}
