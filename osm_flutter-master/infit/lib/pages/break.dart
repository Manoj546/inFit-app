import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infit/pages/startup/Startup.dart';
import 'package:infit/pages/ready/ready.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class breaktime extends StatelessWidget {
  const breaktime({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelsec>(
      create: ((context) => TimerModelsec(context)),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //       image: NetworkImage(
          //         "https://images.unsplash.com/photo-1652475504076-2e052231dcb1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHJlc3QlMjBhZnRlciUyMHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
          //       ),
          //       fit: BoxFit.cover),
          // ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Break Time",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Consumer<TimerModelsec>(
              builder: ((context, myModel, child) {
                return Text(
                  myModel.countdown.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Colors.black),
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Startup()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 15),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}

class TimerModelsec with ChangeNotifier {
  TimerModelsec(context) {
    MyTimer(context);
  }
  int countdown = 20;
  MyTimer(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const rUready()));
      }
    });
  }
}
