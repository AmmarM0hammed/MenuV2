import 'package:flutter/material.dart';

import 'function/routes.dart';
import 'function/theme.dart';

main() => runApp(MenuApp());
class MenuApp extends StatefulWidget {
  MenuApp({Key? key}) : super(key: key);

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
          child: MaterialApp(
        title: "Menu Food",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes, 
        theme: buildThemeData(),
      ),
    );
  }
  ThemeData buildThemeData() {
    return ThemeData(
      fontFamily: "Tajawal",
      scaffoldBackgroundColor: JK_White,
      appBarTheme: AppBarTheme(
        backgroundColor: JK_White,
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: JK_Primery,
      ),
      splashColor: JK_Primery,
    );
  }
}




























