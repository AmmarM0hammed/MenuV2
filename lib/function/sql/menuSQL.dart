import 'dart:typed_data';

import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class MenuDB {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    }
    return _db;
  }

  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'menu.db');
    Database db = await openDatabase(path, onCreate: _onCreate, version: 1);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "menu" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "price" TEXT NOT NULL,
        "disc" TEXT NOT NULL,
        "category" TEXT NOT NULL,
        "image" BLOB NOT NULL,
        "isOver" INTEGER NOT NULL
      )
    ''');

    print("=============================Create!===========================");

    
  }

  selectData(String sql) async {
    Database? myDB = await db;
    List<Map> res = await myDB!.rawQuery(sql);
    return res;
  }

  Future<int> insertData(String sql) async {
    Database? myDB = await db;
    int res = await myDB!.rawInsert(sql);
    // await myDB.insert("Picture", myDB.toMap());
    return res;
  }

  deleteData(String sql) async {
    Database? myDB = await db;
    int res = await myDB!.rawDelete(sql);
    return res;
  }

  updateData(String sql) async {
    Database? myDB = await db;
    int res = await myDB!.rawUpdate(sql);
    return res;
  }


  Future close() async {
    var dbClient = await db;
    dbClient?.close();
  }
}

