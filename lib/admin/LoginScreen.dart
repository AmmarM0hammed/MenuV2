import 'package:flutter/material.dart';
import 'package:menuv2/function/theme.dart';
import 'package:unicons/unicons.dart';
import '../globals.dart' as global;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "lib/assets/image/login.png",
                    fit: BoxFit.fill,
                    height: 400,
                    color: JK_Primery,
                    width: screenWidth(context),
                  ),
                  JK_AppBar(
                      title: "",
                      icon: UniconsLine.arrow_left,
                      onPress: () {
                        Navigator.pop(context);
                      }),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 30),
                                child: Material(
                                  borderRadius: BorderRadius.circular(100),
                                  elevation: 5,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "lib/assets/image/logo1.png"),
                                    radius: 80.0,
                                  ),
                                ),
                              ),
                              Text("تسجيل الدخول",
                                  style: TextStyle(
                                      color: JK_White,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 50),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: JK_Input(
                                  text: " اسم المستخدم",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  backgroundColor: JK_LigtWhite,
                                  borderRadius: 50,
                                  borderColor: JK_Primery,
                                  rightIcon: Icon(
                                    UniconsLine.user,
                                    color: JK_Primery,
                                  ),
                                  isPassword: false,
                                  controler: _username,
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return "يجب ادخال المعلومات";
                                    else {
                                      if (global.usernames != value)
                                        return "اسم المستخدم  خطأ";
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: JK_Input(
                                  text: "كلمة المرور",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  backgroundColor: JK_LigtWhite,
                                  borderRadius: 50,
                                  borderColor: JK_Primery,
                                  rightIcon: Icon(
                                    UniconsLine.lock,
                                    color: JK_Primery,
                                  ),
                                  isPassword: true,
                                  controler: _password,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "يجب ادخال كلمة المرور";
                                    } else {
                                      if (global.passwords != value)
                                        return "اكلمة المرور خطأ";
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 100),
                              JK_Button(
                                  width: 250,
                                  text: "تسجيل الدخول",
                                  backgroundColor: JK_Primery,
                                  borderRadius: 50,
                                  borderColor: JK_Primery,
                                  textColor: JK_White,
                                  onPress: () {
                                    
                                    if (_formKey.currentState!.validate()) {
                                      print("Login");
                                      Navigator.pushNamed(context, "/admin");
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
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
