import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menuv2/admin/UploadScreen.dart';
import 'package:menuv2/function/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unicons/unicons.dart';
import '../model/FoodModels.dart';
import '../model/CategoryModels.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

int _selectIndex = 0;
CategoryView _categoryView = new CategoryView();

class _EditScreenState extends State<EditScreen> {
  String? categoryName;
  Future<String> _categoryName() async {
    categoryName = await _categoryView
        .getData()
        .then((value) => value[_selectIndex]['name']);
    return categoryName.toString();
  }

// TODO GET Mneu Data
  Future<List<Map>> menuData() async {
    MenuView _menuView = await new MenuView();
    _menuView.category = await _categoryName();
    return _menuView.getData();
  }

  void changeData() {
    setState(() {
      categoryName;
      _selectIndex;
    });
  }

   deleteFileLocation(file) async {
    var _file = File(file);
    var res = await _file.delete();

  }

  delete(id, file) async {
    await deleteFileLocation(file);
    MenuDelete _deleteMenu = new MenuDelete();
    var res = await _deleteMenu.deleteData(id: id);
    setState(() {
      print(res);
    });
    
  }

  updateisOver(id, isOver) async {
    MenuUpdate _updateMenu = new MenuUpdate();
    var res = await _updateMenu.updateisOver(id: id, isOver: isOver);
    setState(() {
      print(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            JK_AppBar(
                title: "تعديل وحذف",
                icon: UniconsLine.arrow_left,
                onPress: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 20),
            Category(
              update: changeData,
            ),
            SizedBox(
              height: screenHeight(context) * .75,
              child: FutureBuilder(
                  future: menuData(),
                  builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: (snapshot.hasData) ? snapshot.data!.length : 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  color: JK_White,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black12.withOpacity(.1),
                                      offset: Offset(0, 0),
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(UniconsLine.trash),
                                        onPressed: () {
                                          Alert(
                                            context: context,
                                            type: AlertType.error,
                                            title: "حذف الطبق",
                                            desc: "هل تريد حذف هذا الطبق ؟ ",
                                            buttons: [
                                              DialogButton(
                                                color: Colors.red,
                                                child: Text(
                                                  "نعم",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  delete(
                                                    snapshot.data![index]['id'],
                                                    snapshot.data![index]
                                                        ['image'],
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                width: 120,
                                              ),
                                              DialogButton(
                                                color: JK_LigtGray,
                                                child: Text(
                                                  "لا",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                width: 120,
                                              ),
                                            ],
                                          ).show();
                                        },
                                        splashRadius: 1,
                                        tooltip: "حذف",
                                      ),
                                      IconButton(
                                        icon: Icon(UniconsLine.edit),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/editData",
                                            arguments: {
                                              "id":snapshot.data![index]['id'],
                                              "name":snapshot.data![index]['name'],
                                              "price":snapshot.data![index]['price'],
                                              "disc":snapshot.data![index]['disc'],
                                              "image":snapshot.data![index]['image'],
                                              "category" :snapshot.data![index]['category']
                                            }
                                           
                                          );
                                        },
                                        splashRadius: 1,
                                        tooltip: "تعديل",
                                      ),
                                      Switch(
                                        value: (snapshot.data![index]
                                                    ['isOver'] ==
                                                1)
                                            ? true
                                            : false,
                                        onChanged: (val) {
                                          if (val == true) {
                                            var isOver = 1;
                                            updateisOver(
                                                snapshot.data![index]['id'],
                                                isOver);
                                          } else {
                                            var isOver = 0;
                                            updateisOver(
                                                snapshot.data![index]['id'],
                                                isOver);
                                          }
                                        },
                                        activeColor: JK_Primery,
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              textDirection: TextDirection.rtl,
                                              children: [
                                                Text(
                                                  snapshot.data![index]['name'],
                                                  style: TextStyle(
                                                      color: JK_Black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    snapshot.data![index]
                                                        ['disc'],
                                                    style: TextStyle(
                                                        color: JK_Gray,
                                                        fontSize: 15),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                SizedBox(height: 13),
                                                Text(
                                                  snapshot.data![index]
                                                      ['price'],
                                                  style: TextStyle(
                                                      color: JK_Primery,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              width: 180,
                                              height: 150,
                                              child: Image.file(
                                                File(snapshot.data![index]
                                                    ['image']),
                                                width: 200,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}

class Category extends StatefulWidget {
  final VoidCallback update;
  Category({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FutureBuilder(
        future: _categoryView.getData(),
        builder: (context, AsyncSnapshot<List<Map>> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              color: JK_Primery,
            ));
          else
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: (snapshot.hasData) ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return Center(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                      });
                      widget.update();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data![index]['name'],
                            style: TextStyle(
                                fontSize: 20,
                                color: (_selectIndex == index)
                                    ? JK_Primery
                                    : JK_Gray),
                          ),
                          SizedBox(height: 5),
                          if (_selectIndex == index)
                            Container(
                              width: 50,
                              height: 3,
                              color: JK_Primery,
                            )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
