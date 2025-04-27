import '../../routes/routes_helper.dart';
import '/controllers/popularProductsController.dart';
import '/controllers/cart_controller.dart';
import '/pages/cart/cart_page.dart';
import '/utils/constants.dart';
import '/utils/dimentions.dart';
import '/widgets/appColumn.dart';
import '/widgets/appIcon.dart';
import '/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/bigText.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/smallText.dart';

class PopFoodDetail extends StatelessWidget {
  int pageId;

  PopFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductsController>().popularProductsList[pageId];
    Get.find<PopularProductsController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: Stack(
          children: [
            //main image
            Positioned(
                right: 0,
                left: 0,
                child: Container(
                  width: double.infinity,
                  height: Dimentions.foodImagesize,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.baseUrl +
                              "/uploads/" +
                              product.img))),
                )),
            //navigation bar /
            Positioned(
              top: Dimentions.hight45,
              left: Dimentions.width20,
              right: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios_new)),
                  GetBuilder<PopularProductsController>(builder: (controller) {
                    return InkWell(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelpler.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    iconColor: Colors.transparent,
                                    size: Dimentions.width20,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductsController>().totalItems >= 1
                              ? Positioned(
                                  right: 2,
                                  top: 0,
                                  child: BigText(
                                    text: Get.find<PopularProductsController>()
                                        .totalItems
                                        .toString(),
                                    size: Dimentions.font16,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            //the details part
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimentions.foodImagesize - Dimentions.hight20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      top: Dimentions.hight20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimentions.radius20),
                        topLeft: Radius.circular(Dimentions.radius20),
                      ),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name,
                      ),
                      SizedBox(
                        height: Dimentions.hight20,
                      ),
                      BigText(text: 'Description'),
                      Expanded(
                        child: ExpandableText(text: product.description),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductsController>(builder: (popBuilder) {
          return Container(
            height: Dimentions.bottomHightBar,
            padding: EdgeInsets.only(
              top: Dimentions.hight30,
              bottom: Dimentions.hight30,
              left: Dimentions.width20,
              right: Dimentions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimentions.radius20 * 2),
                topRight: Radius.circular(Dimentions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimentions.hight20,
                      horizontal: Dimentions.hight20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          popBuilder.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimentions.width10 / 2,
                      ),
                      BigText(text: popBuilder.inCartItems.toString()),
                      SizedBox(
                        width: Dimentions.width10 / 2,
                      ),
                      InkWell(
                        onTap: () {
                          popBuilder.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimentions.hight20,
                      horizontal: Dimentions.hight20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: InkWell(
                    onTap: () {
                      popBuilder.addItem(product);
                    },
                    child: BigText(
                      text: "\$ ${product.price} | add to cart",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
