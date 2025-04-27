import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double hight;
  TextOverflow overflow;

  SmallText(
      {super.key,
        this.hight=1.2,
        this.color = const Color(0xFFccc7c5),
        required this.text,
        this.overflow = TextOverflow.ellipsis,
        this.size=12});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

     overflow:overflow,
      style: TextStyle(
        height: hight,
        fontSize: size,
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,

      ),
    );
  }
}
