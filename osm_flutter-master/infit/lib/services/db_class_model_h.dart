import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbClassModel {
  int pageNumber = 0;
  List<Exercise> mainList = [];

  DbClassModel(this.pageNumber);

  Future<List<Exercise>> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    final databasesPath =
        await getDatabasesPath(); //will get default path for database(/data/data/.../databases)
    final path = join(databasesPath,
        "work_wo_equip.db"); //path will be set to infit_datatbase.db
    print('DB Path : $databasesPath');
    print('Path : $path');
    // Check if the database exists
    final exists = await databaseExists(path);
    print('Exists : $exists');
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join("databases", "work_wo_equip.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      print("Bytes : ");
      print(bytes);
      print("Database Created");

      var databasesPath = await getDatabasesPath();
      var new_path = join(databasesPath, "work_wo_equip.db");
      var exists = await databaseExists(new_path);
      print(exists);
    } else {
      print("Opening existing database");
    }
    // open the database
    final db = await openDatabase(path);
    print(db);
    String str = "exercise";
    final List<Map<String, dynamic>> maps = await db.query(str);

    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i]['id'],
        name: maps[i]['name'],
        reps: maps[i]['reps'],
        path: maps[i]['path'],
        cal: maps[i]['cal'],
      );
    });
    //print(mainList);
  }
}

// In the original database I have given different fields
//Will send that ile also
//But check this with only inFit_database.db
class Exercise {
  final int id;
  final String name;
  final String reps;
  final String path;
  final int cal;

  Exercise(
      {required this.id,
      required this.name,
      required this.reps,
      required this.path,
      required this.cal});

  Exercise.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        name = item["name"],
        reps = item["reps"],
        path = item["path"],
        cal = item["cal"];

  Map<String, Object> toMap() {
    return {'id': id, 'name': name, 'reps': reps, 'path': path, 'cal': cal};
  }
}
