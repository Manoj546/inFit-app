import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:infit/pages/Home.dart';
import 'package:infit/pages/report.dart';
import 'package:infit/pages/startup/Startup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Finish extends StatelessWidget {
 int index=0 ;
 List<String> images = ["images/workout_report","images/workout_h_report","images/yoga_report"];
  Finish(int i){
    this.index=i;
  }
 _fetchemail() async {
   final currentUser = FirebaseAuth.instance.currentUser;
   String? email;
   if(currentUser != null){
     email = currentUser.email;
   }
   print(email);
   return email;
 }

 Future<void> shareApp() async {
   await FlutterShare.share(
       title: 'Hey I am using INFIT App',
       text:
       'Hey I am usingINFIT App. It has best  workout  app for all age groups. You should try it once.',
       linkUrl: 'https://flutter.dev/',
       chooserTitle: 'Example Chooser Title');
 }

  _insertData() async{
    String page_name = '';
    String image = '';
    switch(this.index){
      case 1: page_name = "Yoga Exercise";
              image = images[2];
              break;
      case 2: page_name = "Workout with Equipment";
              image = images[0];
              break;

      case 3: page_name = "Home workout";
              image = images[1];
              break;
    }
    String email = await _fetchemail();
    await FirebaseFirestore.instance.collection('user_exercises').doc(email)
                 .collection("exercises").doc().set({
                    "path": image,
                    "name": page_name,
                    "cal": "112 kCal"
                 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Congratulations",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    "https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY=",
                    width: 350,
                    height: 350,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 13, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "128",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "KCal",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Minutes",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Startup()),
                      );
                    },
                    child: Text(
                      "DO IT AGAIN",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  TextButton(
                    onPressed: shareApp,
                    child: Text(
                      "Share",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
            ),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 70,
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Home",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
