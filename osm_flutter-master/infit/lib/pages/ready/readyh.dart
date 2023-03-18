import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infit/pages/workout/workoutdet.dart';
import 'package:provider/provider.dart';

import '../workout/workoutdet_h.dart';

class rUreadyh extends StatelessWidget {
  const rUreadyh({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(context),
      child: Scaffold(
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "ARE YOU READY",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  width: 0,
                  height: 40,
                ),
                Consumer<TimerModel>(builder: (context, myModel, child) {
                  return Text(
                    myModel.countdown.toString(),
                    style: const TextStyle(fontSize: 48),
                  );
                }),
              ]),
        ),
      ),
    );
  }
}

class TimerModel with ChangeNotifier {
  TimerModel(context) {
    MyTimer(context);
  }
  int countdown = 5;
  MyTimer(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorkOutDeth()));
      }
    });
  }
}
