import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infit/pages/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  _fetchemail() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? email;
    if (currentUser != null) {
      email = currentUser.email;
    }
    print(email);
    return email;
  }

  _fetchUserData() async {
    String? email = await _fetchemail();
    return await FirebaseFirestore.instance
        .collection('user_data')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .snapshots();
  }

  _fetchData() async {
    String? email = await _fetchemail();
    return await FirebaseFirestore.instance
        .collection('user_exercise')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('exercise')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Done",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "User Data Report",
                style: TextStyle(fontSize: 20),
              ),
            ),
            leading: Icon(Icons.backpack_sharp),
            actions: [
              IconButton(onPressed: (() {}), icon: Icon(Icons.thumb_up))
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Row(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user_data')
                          .doc(FirebaseAuth.instance.currentUser?.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Container(
                          child: Column(
                            children: [
                              Text("Height : "),
                              Text(snapshot.data?['height'] ?? ""),
                              Divider(
                                height: 2,
                                thickness: 2,
                              ),
                              Text("Weight : "),
                              Text(snapshot.data?['weight'] ?? ""),
                              Divider(
                                height: 2,
                                thickness: 2,
                              ),
                              Text("BMI : "),
                              Text(snapshot.data?['bmi'] ?? ""),
                              Divider(
                                height: 2,
                                thickness: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Text("Exercises Done"),
                Divider(
                  thickness: 2,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user_exercises')
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .collection('exercise')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if(snapshot.hasError){
                      return Text("SOME ERROR OCCCURED");
                    }
                      else {
                        print(snapshot.data.docs[0]['path']);
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                                thickness: 2,
                              ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot data = snapshot.data.docs[index];
                            return ListTile(
                              leading: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Image.asset(
                                    snapshot.data?['path'] ?? "No Data",
                                    fit: BoxFit.cover,
                                  )),
                              title: Text(
                                snapshot.data?['name'] ?? "No Data",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              subtitle: Text(
                                snapshot.data?['cal'] ?? "No Data",
                                style: const TextStyle(fontSize: 15),
                              ),
                            );
                          },
                          itemCount: snapshot.data.docs.length);
                    }
                  },
                ),
                Text("data"),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
