import '../../controllers/popularProductsController.dart';
import '../../controllers/recomendedController.dart';
import '/pages/home/foodPageBody.dart';
import '/utils/dimentions.dart';
import '/widgets/bigText.dart';
import '/utils/colors.dart';
import '/widgets/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void>_loadResorces()async{
    await Get.find<PopularProductsController>().getPopularProductsList();
    await Get.find<RecomendedProductsController>().getRecommendedProductsList();
  }
  @override
  Widget build(BuildContext context) {
    //on refresh instead of scaffold so u can refresh and get data from backend again to see updates 
    return RefreshIndicator(child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: Dimentions.hight45, bottom: Dimentions.hight15),
          padding: EdgeInsets.only(
              left: Dimentions.width20, right: Dimentions.width20),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'The Best Food',
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: 'Narshindi',
                          color: Colors.black,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: Dimentions.hight45,
                    width: Dimentions.hight45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimentions.iconSize24,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                        BorderRadius.circular(Dimentions.radius15)),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: FoodPageBody())),
      ],
    ), onRefresh:_loadResorces);
  }
}
