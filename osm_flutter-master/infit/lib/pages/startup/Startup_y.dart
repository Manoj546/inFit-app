import 'package:flutter/material.dart';
import 'package:infit/services/db_class_model_y.dart';

import '../ready/readyy.dart';

class Startupy extends StatefulWidget {
  const Startupy({super.key});

  @override
  State<Startupy> createState() => _StartupState();
}

class _StartupState extends State<Startupy> {
  DbClassModel dbcm = DbClassModel(1);
  _fetchdata() async {
    return await dbcm.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => rUreadyy()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "START",
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
                  "Yoga series",
                  style: TextStyle(fontSize: 20),
                ),
                background: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsnznDJUukXBX1nqekJ1LD9O0H54yKCmIUVcoXj6Rl&s",
                  fit: BoxFit.cover,
                )),
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
                    Text("16 Min || 26 Workout",
                        style: TextStyle(fontWeight: FontWeight.w500))
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                FutureBuilder(
                  future: _fetchdata(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      print(snapshot.data);
                      // return Text(
                      //   '${snapshot.data[0].id}',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //   ),
                      // );
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                                thickness: 2,
                              ),
                          itemBuilder: (context, index) => ListTile(
                                leading: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      snapshot.data[index].path,
                                      fit: BoxFit.cover,
                                    )),
                                title: Text(
                                  snapshot.data[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  snapshot.data[index].reps,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                          itemCount: snapshot.data.length);
                    }
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
