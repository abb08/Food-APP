import '/utils/colors.dart';
import '/utils/dimentions.dart';
import '/widgets/bigText.dart';
import '/widgets/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  // why i cant use text in the build  child class unless after widget
  // i mean the child class extends it and that makes sence

  ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHlaf;
  late String secondHlaf;
  bool hiddenText = true;
  double textHight = Dimentions.screenHight / 5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHight) {
      firstHlaf = widget.text.substring(0, textHight.toInt());
      secondHlaf =
          widget.text.substring(textHight.toInt() + 1, widget.text.length);
    } else {
      firstHlaf = widget.text;
      secondHlaf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: secondHlaf.isEmpty
            ?  SmallText(
            color: AppColors.paraColor,
            size: Dimentions.font16,// cant make it the default cause it has to be a constatnt in the  constructure
            text: (firstHlaf ))
            : Column(
                children: [
                  SmallText(
                    overflow: TextOverflow.visible,
                    color: AppColors.paraColor,
                      size: Dimentions.font16,// cant make it the default cause it has to be a constatnt in the  constructure
                      text: hiddenText
                          ? (firstHlaf + '...')
                          : (firstHlaf + secondHlaf)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText=!hiddenText;
                      });
                    },
                 child: Row(
                   children: [
                     SmallText(size: Dimentions.font16,text: hiddenText?"show more":"show less",color: AppColors.mainColor,),
                     Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
                   ],
                 ),

                  )
                ],
              ),
      ),
    );
  }
}
