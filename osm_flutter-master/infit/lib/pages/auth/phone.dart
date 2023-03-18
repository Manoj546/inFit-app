import 'package:flutter/material.dart';
import 'package:infit/pages/Home.dart';
import 'package:infit/pages/auth/login.dart';

void main() => runApp(const Phone());

class Phone extends StatelessWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Phone Login",
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Phone No Login",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Phone no",
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 60, //height of button
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      },
                      child: const Text(
                        "Google",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
              SizedBox(
                height: 60, //height of button
                width: 200,
                child: ElevatedButton(
                    child: const Text(
                      "Email",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                      //Navigator.pop(context);
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
