import 'package:flutter/material.dart';

class ex extends StatelessWidget {
  const ex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(" Yoga"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: const [Text("1"), Text("Streak")]),
                Column(children: const [Text("1"), Text("Streak")]),
                Column(children: const [Text("1"), Text("Streak")])
              ],
            ),
          ),
          const Divider(
            thickness: 23,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(" Yoga for all"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: Colors.blueGrey,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: Colors.blueGrey,
                  height: 150,
                ),
              )
            ]),
          ),
          Container(
            padding: EdgeInsets.all(25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(" Yoga for students"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: Colors.blueGrey,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: Colors.blueGrey,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: Colors.blueGrey,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: Colors.blueGrey,
                  height: 150,
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
