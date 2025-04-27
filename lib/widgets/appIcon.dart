import '/utils/dimentions.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  AppIcon({
    super.key,
    this.iconSize=16,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d45),
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Center(
          child: Icon(
        icon,
        color: iconColor,
        size: iconSize,

      ),
      ),

    );
  }
}
