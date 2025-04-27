import '/utils/dimentions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size=0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontSize: size==0? Dimentions.font20:size,

        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,

      ),
    );
  }
}
