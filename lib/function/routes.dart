import 'package:flutter/material.dart';
import 'package:menuv2/admin/EditData.dart';
import 'package:menuv2/admin/EditScreen.dart';
import 'package:menuv2/admin/LoginScreen.dart';
import 'package:menuv2/admin/HomeScreen.dart';
import 'package:menuv2/component/ViewImage.dart';

import '../admin/CategoryScreen.dart';
import '../admin/UploadScreen.dart';
import '../screen/HomeScreen.dart';
import '../screen/ViewScreen.dart';

var routes = {
  "/": (context) => HomeScreen(),
  "/view": (context) => ViewScreen(),
  "/login": (context) => LoginScreen(),
  "/admin": (context) => HomeScreenAdmin(),
  "/upload": (context) => UploadScreen(),
  "/edit": (context) => EditScreen(),
  "/category": (context) => CategoryScreen(),
  "/editData": (context) => EditDataScreen(),
  "/viewImage": (context) => ViewImage(),
};
