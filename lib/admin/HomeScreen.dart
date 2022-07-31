import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../function/theme.dart';

class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              JK_AppBar(
                title: "وحدة التحكم",
                icon: UniconsLine.home_alt,
                onPress: () {
                  Navigator.pushNamed(context, "/");
                },
              ),
              SizedBox(height: 25),
              SizedBox(
                height: screenHeight(context),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    cardAdmin(
                      title: "اضافة طبق",
                      icon: UniconsLine.file_plus,
                      goTo: "/upload",
                      context: context
                    ),
                    cardAdmin(
                      title: "تعديل او حذف الاطباق",
                      icon: UniconsLine.edit,
                      goTo: "/edit",
                      context: context
                    ),
                    cardAdmin(
                      title: "الأقسام",
                      icon: UniconsLine.list_ol,
                      goTo: "/category",
                      context: context
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding cardAdmin({String? title, IconData? icon, goTo, context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '$goTo');
        },
        splashColor: Colors.transparent,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(UniconsLine.angle_left_b, size: 30, color: JK_Primery),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 10),
                        child: Text(title!,
                            style: TextStyle(
                                color: JK_Black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500)),
                      ),
                      Icon(
                        icon,
                        size: 30,
                        color: JK_Primery,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
