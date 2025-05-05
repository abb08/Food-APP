import '/utils/dimentions.dart';
import '/widgets/smallText.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;

  IconAndTextWidget(
      {super.key,
      required this.icon,
      required this.text,

      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimentions.iconSize16*1.2,),
        SizedBox(width: 5,),
        SmallText(text: text,),

      ],
    );
  }
}
