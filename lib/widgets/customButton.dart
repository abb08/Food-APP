import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool transparent;
  final double? width;
  final double? height;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final EdgeInsets? margin;

  Custombutton(
      {super.key,
      required this.buttonText,
      this.onPressed,
      this.transparent = false,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 5,
      this.icon,
      this.margin});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonstyle = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : Theme.of(context).primaryColor,
        minimumSize: Size(width != null ? width! : Dimentions.screenWidth,
            height != null ? height! : Dimentions.hight10 * 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ));

    return Center(
      child: SizedBox(
        width: width ?? Dimentions.screenWidth,
        height: height ?? Dimentions.hight10 * 5,
        child: TextButton(
            onPressed: onPressed ?? () {},
            style: _flatButtonstyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(right: Dimentions.width10 / 2),
                        child: Icon(
                          icon,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        ),

                      ),
                Text(buttonText??"",style: TextStyle(
                  color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,
                  fontSize: fontSize??Dimentions.font16,
                ),),
              ],
            )),
      ),
    );
  }
}
