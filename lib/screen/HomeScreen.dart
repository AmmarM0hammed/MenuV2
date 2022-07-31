import 'package:flutter/material.dart';
import 'package:menuv2/component/FoodCard.dart';
import 'package:menuv2/model/CategoryModels.dart';
import 'package:menuv2/model/FoodModels.dart';
import 'package:unicons/unicons.dart';
import '../component/Category.dart';
import '../function/theme.dart';

//? category Index
int selectIndex = 0;
String? nameSearch;
CategoryView _categoryView = new CategoryView();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// TODO GET category Name
String? categoryName;
Future<String> _categoryName() async {
  categoryName =
      await _categoryView.getData().then((value) => value[selectIndex]['name']);
  return categoryName.toString();
}

// TODO GET Mneu Data
Future<List<Map>> menuData() async {
  MenuView _menuView = await new MenuView();
  _menuView.category = await _categoryName();
  _menuView.nameSearch = nameSearch;
  _menuView.isOver = 1;
  return _menuView.getData();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _search = new TextEditingController();

  //? update Data from category
  void changeData() {
    setState(() {
      categoryName;
      selectIndex;
    });
    print("Update!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              JK_AppBar(
                title: "الرئيسية",
                icon: UniconsLine.user,
                onPress: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
              SizedBox(height: 25),
              SearchBar(
                  formKey: _formKey, controller: _search, update: changeData),
              SizedBox(height: 25),
              Category(
                update: () {
                  changeData();
                },
              ),
              SizedBox(height: 25),
              SizedBox(
                height: screenHeight(context) * .63,
                child: FutureBuilder(
                    future: menuData(),
                    builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              (snapshot.hasData) ? snapshot.data!.length : 0,
                          itemBuilder: (context, index) {
                            return FoodCard(
                              id: snapshot.data![index]['id'],
                              name: snapshot.data![index]['name'],
                              price: snapshot.data![index]['price'],
                              disc: snapshot.data![index]['disc'],
                              image: snapshot.data![index]['image'],
                              category: snapshot.data![index]['category'],
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final formKey;
  final TextEditingController controller;

  final update;
  SearchBar({Key? key, this.formKey, required this.controller, this.update})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        child: Form(
          key: widget.formKey,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                print("change");
                nameSearch = value;
              });
            },
            autofocus: false,
            cursorColor: JK_Primery,
            controller: widget.controller,
            textDirection: TextDirection.rtl,
            keyboardType: TextInputType.text,
            style: TextStyle(color: JK_Gray, fontSize: 19),
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                focusColor: JK_Primery,
                suffixIcon: Icon(
                  UniconsLine.search,
                  color: JK_Gray,
                ),
                suffixIconColor: JK_Gray,
                hintText: ".... البحث",
                fillColor: JK_LigtWhite,
                filled: true,
                prefixIconColor: JK_Primery,
                prefixIcon: (widget.controller.text.isEmpty)
                    ? null
                    : IconButton(
                        icon: Icon(UniconsLine.times),
                        onPressed: () {
                          widget.controller.text = "";
                          nameSearch = null;
                          widget.update();
                          setState(() {});
                        },
                        splashColor: Colors.transparent)),
            obscureText: false,
          ),
        ),
      ),
    );
  }
}
