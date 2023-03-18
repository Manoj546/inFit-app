import 'package:flutter/material.dart';
import 'package:infit/pages/diabetic.dart';
import 'package:infit/pages/gastric.dart';
import 'bp.dart';
import 'geendiet.dart';
import 'startup/Startup.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_drawer.dart';

class Diet extends StatefulWidget {
  const Diet({super.key});

  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<Diet> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorsTween, _homeTween, _yogaTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
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
        AnimationController(vsync: this, duration: Duration(seconds: 0));
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
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: Colors.black,

      body: NotificationListener(
          onNotification: scrollListner,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(50, 120, 50, 30),
                                decoration: BoxDecoration(
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
                                        children: [
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
                                        children: [
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
                                        children: [
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
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Diet Plans",
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
                                              builder: (context) => FullScreenPage1()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage('images/img1.jpg'),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            30)
                                                    )
                                                )
                                            ),
                                            Container(
                                              height: 150,
                                              //color: Colors.lightGreenAccent,
                                            ),
                                            Positioned(
                                              right: 20,
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                "General Diet",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Positioned(
                                              right: 30,
                                              left: 10,
                                              top: 42, 
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FullScreenPage3()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage("images/sugar.jpg"),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            30)))),
                                            Container(
                                              height: 150,
                                              //color: Colors.lightGreenAccent,
                                            ),
                                            Positioned(
                                              right: 20,
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                "Diabetic Diet",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Positioned(
                                              right: 30,
                                              left: 10,
                                              top: 42,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        BoxFit.cover;
                                        AssetImage("images/img2.jpg");
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FullScreenPage2()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage("images/img2.jpg")
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            30)))),
                                            Container(
                                              height: 150,
                                              //color: Colors.lightGreenAccent,
                                            ),
                                            Positioned(
                                              right: 20,
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                "Diet for BP",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Positioned(
                                              right: 30,
                                              left: 10,
                                              top: 42,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FullScreenPage4()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage("images/img3.jpg")
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            30)))),
                                            Container(
                                              height: 150,
                                              //color: Colors.lightGreenAccent,
                                            ),
                                            Positioned(
                                              right: 20,
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                "Gastric Diet",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Positioned(
                                              right: 30,
                                              left: 10,
                                              top: 42,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
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
