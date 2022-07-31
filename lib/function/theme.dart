import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

const Color JK_Primery = Color.fromRGBO(245, 155, 73, 1);
const Color JK_White = Color.fromRGBO(252, 252, 252, 1);
const Color JK_Black = Color.fromRGBO(33, 33, 33, 1);
const Color JK_Gray = Color.fromRGBO(127, 127, 127, 1);
const Color JK_LigtGray = Color.fromRGBO(33, 33, 33, .5);
const Color JK_LigtWhite = Color.fromRGBO(244, 244, 244, 1);

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class JK_AppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final Color color;
  const JK_AppBar(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.color = JK_Black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: onPress,
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: JK_White,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      spreadRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 30),
            ),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
  }
}

//TODO Input

class JK_Input extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final int maxLength;
  final int maxLine;
  final TextDirection textDirection;
  final TextInputType keyboard;
  final TextStyle textStyle;
  final EdgeInsets contentPadding;
  final TextStyle hintStyle;
  final bool isBorder;
  final bool isPassword;
  final double borderRadius;
  final TextAlign textAlign;
  final Color borderColor;
  final double borderWidth;
  final TextEditingController? controler;
  final String? Function(String?)? validator;

  final Icon? leftIcon;
  final Icon? rightIcon;
  const JK_Input(
      {Key? key,
      this.text = "JK_INPUT",
      this.color = Colors.red,
      this.backgroundColor = Colors.black12,
      this.maxLength = 0,
      this.maxLine = 1,
      this.textDirection = TextDirection.ltr,
      this.keyboard = TextInputType.text,
      this.textStyle = const TextStyle(fontSize: 16),
      this.contentPadding = const EdgeInsets.all(0),
      this.hintStyle = const TextStyle(fontSize: 16),
      this.isBorder = true,
      this.isPassword = false,
      this.borderRadius = 15,
      this.controler,
      this.validator,
      this.textAlign = TextAlign.left,
      this.borderColor = Colors.red,
      this.borderWidth = 1, 
      this.leftIcon, 
      this.rightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength:(maxLength != 0) ? maxLength : null,
      maxLines: maxLine,
      cursorHeight: 20,
      cursorColor: color,
      controller: controler,
      validator: validator,
      textDirection: textDirection,
      keyboardType: keyboard,
      style: textStyle,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: (isBorder)
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: (isBorder)
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: (isBorder)
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        hintText: text,
        fillColor: backgroundColor,
        filled: true,
        prefixIcon: (leftIcon != null) ? leftIcon : null,
        suffixIcon: (rightIcon != null) ? rightIcon : null,
      ),
      obscureText: isPassword,
    );
  }
}

//TODO Button

class JK_Button extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight textWeight;
  final Color textColor;
  final Color backgroundColor;
  final double height;
  final double width;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool isIcon;
  final IconData icon;
  final onPress;

  const JK_Button(
      {Key? key,
      this.text = "",
      this.textSize = 15.0,
      this.textColor = Colors.white,
      this.textWeight = FontWeight.normal,
      this.backgroundColor = Colors.black,
      this.height = 50,
      this.width = 50,
      this.borderRadius = 10.0,
      this.borderColor = Colors.white,
      this.borderWidth = 0,
      this.isIcon = false,
      this.icon = Icons.arrow_forward_ios_sharp,
      this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),


        
        child: Center(
          child: (!isIcon)
              ? Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: textSize,
                      fontWeight: textWeight),
                )
              : Icon(
                  icon,
                  color: textColor,
                  size: textSize,
                ),
        ),
      ),
    );
  }
}
