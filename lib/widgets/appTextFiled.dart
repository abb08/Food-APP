import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimentions.dart';

class Apptextfiled extends StatelessWidget {
  final TextEditingController textController;
  String hintText;
  IconData icon;
  bool isUpsecue;

  Apptextfiled(
      {super.key,
        this.isUpsecue=false,
      required this.textController,
      required this.icon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimentions.hight20,
        vertical: Dimentions.hight15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimentions.radius30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 30,
              spreadRadius: 7,
              offset: Offset(1, 10),
              color: Colors.grey.withOpacity(0.2))
        ],
      ),
      child: TextField(
        obscureText: isUpsecue,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.mainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
          ),
        ),
      ),
    );
  }
}
