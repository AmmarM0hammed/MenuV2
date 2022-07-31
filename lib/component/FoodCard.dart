import 'dart:io';

import 'package:flutter/material.dart';
import '../function/theme.dart';

class FoodCard extends StatelessWidget {
  final int id;
  final String name;
  final String price;
  final String disc;
  final String image;
  final String category;
  const FoodCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.disc,
      required this.image,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context, "/view",
            arguments: {
              "id":id,
              "name":name,
              "price":price,
              "disc":disc,
              "image":image,
              "category" : category
            },
            
          );
         
        },
        splashColor: Colors.transparent,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              color: JK_White,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12.withOpacity(.1),
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: JK_Black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          disc,
                          style: TextStyle(color: JK_Gray, fontSize: 15),
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 13),
                      Text(
                        price,
                        style: TextStyle(
                            color: JK_Primery,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "img$id",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 180,
                      height: 150,
                      child: Image.file(
                        File(image),
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCardView extends StatelessWidget {
  final int id;
  final String name;
  final String price;
  final String disc;
  final String image;
  final String category;
  const FoodCardView(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.disc,
      required this.image,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context, "/view",
            arguments: {
              "id":id,
              "name":name,
              "price":price,
              "disc":disc,
              "image":image,
              "category" : category
            },
            
          );
        },
        splashColor: Colors.transparent,
        child: Container(
          height: 280,
          width: 250,
          decoration: BoxDecoration(
              color: JK_White,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12.withOpacity(.1),
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 230,
                        height: 150,
                        child: Image.file(
                          File(image),
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    name,
                    style: TextStyle(
                        color: JK_Black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    price,
                    style: TextStyle(
                        color: JK_Primery,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
