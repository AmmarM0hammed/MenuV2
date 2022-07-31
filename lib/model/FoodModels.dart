import 'package:flutter/material.dart';
import '../function/sql/menuSQL.dart';

class MenuAdd {
  final String name;
  final String price;
  final String disc;
  final String category;
  final String image;
  final int isOver;
  MenuDB _menuSQL = new MenuDB();
  MenuAdd(
      {required this.name,
      required this.price,
      required this.disc,
      required this.category,
      required this.image,
      this.isOver = 1});

  Future<int> addMenu() async {
    if (name.isNotEmpty) {
      int _res = await _menuSQL.insertData(
          "INSERT INTO menu ('name' , 'price' , 'disc','category','image','isOver') VALUES ('$name' , '$price' , '$disc' , '$category' , '$image' , '$isOver')");
      return _res;
    }
    return 0;
  }
}

class MenuView {
  MenuDB _menuSQL = new MenuDB();
  String? category;
  String? nameSearch;
  int? isOver;
  MenuView({this.category});

  Future<List<Map>> getData() async {
    if (nameSearch == null) {
      if (isOver == null) {
        List<Map> res = await _menuSQL.selectData(
            "Select * FROM menu WHERE category ='$category'");
        return res;
      }
      else{
        List<Map> res = await _menuSQL.selectData(
            "Select * FROM menu WHERE category ='$category' AND isOver = '$isOver'");
        return res;
      }
    } else {
      List<Map> res = await _menuSQL.selectData(
          "Select * FROM menu WHERE category ='$category' AND name LIKE '%$nameSearch%'");
      return res;
    }
  }
}

class MenuDelete {
  MenuDB _menuSQL = new MenuDB();

  MenuDelete();
  deleteData({required int id}) async {
    var res = await _menuSQL.deleteData("DELETE FROM menu WHERE id = '$id'");
    return res;
  }
}

class MenuUpdate {
  MenuDB _menuSQL = new MenuDB();

  updateisOver({required int id, required int isOver}) async {
    var res = await _menuSQL
        .updateData("UPDATE menu SET isOver = '$isOver' WHERE id = '$id'");
    return res;
  }

  update(
    {
     required int id,
     required String name,
     required String price,
     required String disc,
     required String image,
     required String category,     
    }
  ) async{
    var res = await _menuSQL
        .updateData("UPDATE menu SET name = '$name' , price = '$price' , disc = '$disc' , image = '$image' , category = '$category' WHERE id = '$id'");
    return res;
  }
}
