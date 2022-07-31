import 'package:flutter/material.dart';
import 'package:menuv2/model/CategoryModels.dart';
import 'package:unicons/unicons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../function/theme.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _categoryName = new TextEditingController();
  CategoryView _categoryView = new CategoryView();
  CategoryDelete _categoryDelete = new CategoryDelete();

  // TODO form Submit model
  _formSubmit() async {
    if (_formKey.currentState!.validate()) {
      CategoryAdd _categoryAdd =
          new CategoryAdd(name: _categoryName.value.text);
      print(await _categoryAdd.addCategory());

      setState(() {});
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addModal();
        },
        child: Icon(UniconsLine.plus),
        backgroundColor: JK_Primery,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              JK_AppBar(
                  title: " اضافة وتعديل الاقسام",
                  icon: UniconsLine.angle_left,
                  onPress: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                height: screenHeight(context) * .8,
                child: FutureBuilder(
                    future: _categoryView.getData(),
                    builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              (snapshot.hasData) ? snapshot.data!.length : 0,
                          itemBuilder: (builder, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height: 80,
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          splashColor: Colors.transparent,
                                          icon: Icon(UniconsLine.multiply,
                                              size: 30, color: JK_Primery),
                                          onPressed: () {
                                            Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: "حذف القسم",
                                              desc:
                                                  "هل تريد حذف هذا القسم ؟ ",
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
                                                    _categoryDelete.deleteData(
                                                        id: snapshot
                                                                .data![index]
                                                            ['id']);

                                                    setState(() {});
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, right: 10),
                                          child: Text(
                                              (snapshot.hasData)
                                                  ? snapshot.data![index]
                                                      ['name']
                                                  : "",
                                              style: TextStyle(
                                                  color: JK_Black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(" اضافة قسم",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: JK_Input(
                        text: " اسم القسم",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        backgroundColor: JK_LigtWhite,
                        borderRadius: 50,
                        borderColor: JK_Primery,
                        rightIcon: Icon(
                          UniconsLine.restaurant,
                          color: JK_Primery,
                        ),
                        maxLength: 20,
                        controler: _categoryName,
                        validator: (val) {
                          if (val!.isEmpty) return "اسم القسم مطلوب";
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    JK_Button(
                        width: 250,
                        text: "اضافة",
                        backgroundColor: JK_Primery,
                        borderRadius: 50,
                        borderColor: JK_Primery,
                        textColor: JK_White,
                        onPress: () {
                          _formSubmit();
                        }),
                  ],
                ),
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )));
  }
}
