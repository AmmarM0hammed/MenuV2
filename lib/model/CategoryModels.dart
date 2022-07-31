import 'package:flutter/material.dart';
import '../function/sql/categorySQL.dart';

class CategoryAdd {
  final String name;
  CategoryDB _categorySQL = new CategoryDB();
  CategoryAdd({required this.name});

  Future<int> addCategory() async {
    if (name.isNotEmpty) {
      int _res = await _categorySQL
          .insertData("INSERT INTO category ('name') VALUES ('$name')");
      return _res;
    }
    return 0;
  }
}

class CategoryView {
  CategoryDB _categorySQL = new CategoryDB();

  Future<List<Map>> getData() async {
    List<Map> res = await _categorySQL.selectData("Select * FROM category");
    return res;
  }
}

class CategoryDelete {
  CategoryDB _categorySQL = new CategoryDB();

  CategoryDelete();
   deleteData({required int id}) async {
    var res = await _categorySQL.deleteData("DELETE FROM category WHERE id = '$id'");
    return res;
  }
}
 