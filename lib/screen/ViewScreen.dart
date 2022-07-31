import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:menuv2/component/ViewImage.dart';
import 'package:menuv2/function/theme.dart';
import 'package:menuv2/model/FoodModels.dart';
import 'package:unicons/unicons.dart';

import '../component/FoodCard.dart';

class ViewScreen extends StatefulWidget {
  ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    Future<List<Map>> menuData() async {
      MenuView _menuView = await new MenuView(category: routes['category']);

      return _menuView.getData();
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              JK_AppBar(
                title: routes['name'],
                icon: UniconsLine.arrow_left,
                onPress: () {
                  Navigator.pushNamed(context,'/');
                },
                color: JK_Black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/viewImage",
                          arguments: {"image":routes['image']});
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: screenWidth(context) - 10,
                        child: Hero(
                          tag: "img${routes['id']}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File(routes['image']),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          routes['price'],
                          style: TextStyle(
                              fontSize: 25,
                              color: JK_Primery,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          routes['name'],
                          style: TextStyle(
                            fontSize: 25,
                            color: JK_Black,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      routes['disc'],
                      style: TextStyle(
                        fontSize: 17,
                        color: JK_Gray,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      routes['category'],
                      style: TextStyle(
                        fontSize: 16,
                        color: JK_Gray,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: FutureBuilder(
                      future: menuData(),
                      builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (snapshot.hasData) ? snapshot.data!.length : 0,
                          itemBuilder: (context, index) {
                            if (snapshot.data![index]['id'] != routes['id'])
                              return FoodCardView(
                                id: snapshot.data![index]['id'],
                                name: snapshot.data![index]['name'],
                                price: snapshot.data![index]['price'],
                                disc: snapshot.data![index]['disc'],
                                image: snapshot.data![index]['image'],
                                category: snapshot.data![index]['category'],
                              );
                            else
                              return Center(child: Text(""));
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
