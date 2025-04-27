import 'dart:ffi';

import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/appIcon.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AccountItem extends StatelessWidget {
  String text;
  IconData icon;
  Color backgorundColor;

  AccountItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.backgorundColor,
        });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimentions.hight10),
      padding: EdgeInsets.only(
          top: Dimentions.hight10,
          bottom: Dimentions.hight10,
          left: Dimentions.hight20),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            iconColor: Colors.white,
            backgroundColor: backgorundColor,
            iconSize: Dimentions.hight10 * 2.5,
            size: Dimentions.hight10 * 5,
          ),
          SizedBox(
            width: Dimentions.hight20,
          ),
          BigText(
            text: text,
            size: 24,
            color: Colors.black,
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
    );
  }
}
