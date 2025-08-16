import '/widgets/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'bigText.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {

  final String text;
  AppColumn({super.key,required this.text} );

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimentions.font26,),
        SizedBox(
          height: Dimentions.hight10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  size: Dimentions.iconSize16,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            SmallText(text: '4.5'),
            SmallText(text: '1480'),
            SmallText(text: 'comments'),
          ],
        ),
        SizedBox(
          height: Dimentions.hight10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconAndTextWidget(
                icon: Icons.circle,
                text: 'normal',
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: '1.7 km',
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: '32 mis',
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
