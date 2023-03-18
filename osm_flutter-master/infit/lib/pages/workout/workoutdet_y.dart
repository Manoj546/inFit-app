import 'dart:async';
import 'package:infit/pages/Home.dart';
import 'package:infit/pages/startup/Startup_y.dart';
import 'package:infit/pages/finish/finishy.dart';
import 'package:infit/services/db_class_model_y.dart';
import 'package:flutter/material.dart';
import 'package:infit/pages/break.dart';
import 'package:provider/provider.dart';

import '../startup/Startup_y.dart';

class WorkOutDety extends StatefulWidget {
  const WorkOutDety({super.key});

  @override
  State<WorkOutDety> createState() => _WorkOutDetState();
}

class _WorkOutDetState extends State<WorkOutDety> {
  int id = 0;
  var index = 0;

  DbClassModel dbcm = DbClassModel(1);
  _fetchdata() async {
    return await dbcm.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchdata(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ChangeNotifierProvider<TimerModelsec>(
          create: (context) => TimerModelsec(context),
          child: Scaffold(
              body: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 350,
                        child: Image.asset(
                          snapshot.data[index].path,
                          fit: BoxFit.fitWidth,
                        )),
                    Container(
                      child: Text(
                        snapshot.data[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("00",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          const Text(":",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          Consumer<TimerModelsec>(
                            builder: ((context, myModel, child) {
                              return Text(
                                myModel.countdown.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer<TimerModelsec>(
                      builder: ((context, myModel, child) {
                        return ElevatedButton(
                          onPressed: () {
                            myModel.show();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: const Text("PAUSE",
                                style: TextStyle(fontSize: 20)),
                          ),
                        );
                      }),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  id -= 1;

                                  if (index == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Startupy()));
                                  } else {
                                    index -= 1;
                                  }

                                  print(index);
                                  print(id);
                                });
                              },
                              child: const Text(
                                "Previous",
                                style: TextStyle(fontSize: 16),
                              )),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  print(index);
                                  print(snapshot.data.length);
                                  if (index < snapshot.data.length - 1) {
                                    id += 1;
                                    index += 1;
                                  } else {
                                    print("else");
                                    print(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Finish(3)));
                                  }
                                });
                              },
                              child: const Text(
                                "Next",
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    const Divider(thickness: 2),
                    const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          // child: Text(
                          //   "Next : yoga",
                          //   style: TextStyle(fontSize: 20),
                          // ),
                        )),
                  ],
                ),
              ),
              Consumer<TimerModelsec>(
                builder: ((context, myModel, child) {
                  return Visibility(
                    visible: myModel.visible,
                    child: Container(
                      padding: EdgeInsets.all(25),
                      color: Colors.blueAccent.withOpacity(0.9),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PAUSE",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Startupy()));
                              },
                              child: Text(
                                "RESTART",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                              child: Text(
                                "QUIT",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                myModel.hide();
                              },
                              child: Text(
                                "RESUME",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                            )
                          ]),
                    ),
                  );
                }),
              ),
            ],
          )),
        );
      },
    );
  }
}

class TimerModelsec with ChangeNotifier {
  TimerModelsec(context) {
    MyTimer(context);
  }
  int countdown = 180;
  bool visible = false;
  MyTimer(context) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => breaktime()));
      }
    });
  }

  void cancel() {}

  void show() {
    visible = true;
    notifyListeners();
  }

  void hide() {
    visible = false;
    notifyListeners();
  }
}
