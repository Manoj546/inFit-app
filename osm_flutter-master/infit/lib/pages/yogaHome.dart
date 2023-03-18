import 'package:flutter/material.dart';
import 'package:infit/pages/startup/Startup.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_drawer.dart';

class yogaHome extends StatefulWidget {
  const yogaHome({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<yogaHome> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorsTween, _homeTween, _yogaTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorsTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue)
        .animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_animationController);
    _yogaTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    super.initState();
  }

  bool scrollListner(ScrollNotification scrollNotification) {
    bool scroll = false;
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels / 80);
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);
      return scroll == true;
    }

    return scroll;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //user.email
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      backgroundColor: Colors.black54,
      body: NotificationListener(
          onNotification: scrollListner,
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 120, 50, 30),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30)),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: const [
                                          Text("1",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23)),
                                          Text("Streak",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Column(
                                        children: const [
                                          Text("120",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23)),
                                          Text("kCal",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Column(
                                        children: const [
                                          Text("25",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23)),
                                          Text("Minutes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13))
                                        ],
                                      )
                                    ]),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(
                                        "Daily Yoga",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Startup()),
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: 150,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "https://tse2.mm.bing.net/th?id=OIP.e5gkQ1YBkzqKgzzB76aCNAHaF7&pid=Api&P=0"),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)))),
                                            Container(
                                              height: 150,
                                              color: Colors.black26,
                                            ),
                                            const Positioned(
                                              right: 20,
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                "Yoga for beginners",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            const Positioned(
                                              right: 30,
                                              left: 10,
                                              top: 42,
                                              child: Text(
                                                "Last time : 2 Nov",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(
                                        children: [
                                          Container(
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHlvZ2ElMjBoZWFsdGh8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30)))),
                                          Container(
                                            height: 150,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 15,
                                            child: Text(
                                              "Intermediate Yoga",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          const Positioned(
                                            right: 30,
                                            left: 10,
                                            top: 42,
                                            child: Text(
                                              "Last time : 2 Nov",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(
                                        "Daily Routine",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(
                                        children: [
                                          Container(
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z3ltfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30)))),
                                          Container(
                                            height: 150,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 15,
                                            child: Text(
                                              "Yoga for Advanced",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          const Positioned(
                                            right: 30,
                                            left: 10,
                                            top: 42,
                                            child: Text(
                                              "Last time : 2 Nov",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(
                                        children: [
                                          Container(
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://images.unsplash.com/photo-1488228469209-c141f8bcd723?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8eW9nYSUyMGhlYWx0aHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30)))),
                                          Container(
                                            height: 150,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 15,
                                            child: Text(
                                              "Yoga Challenge",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          const Positioned(
                                            right: 30,
                                            left: 10,
                                            top: 42,
                                            child: Text(
                                              "Last time : 2 Nov",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Custom_appbar(
                        animationController: _animationController,
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        colorsTween: _colorsTween,
                        homeTween: _homeTween,
                        yogaTween: _yogaTween,
                        iconTween: _iconTween,
                        drawerTween: _drawerTween)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
