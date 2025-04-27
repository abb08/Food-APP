import 'package:ecoomerce_dbestech/routes/routes_helper.dart';

import '/controllers/popularProductsController.dart';
import '/controllers/recomendedController.dart';
import '/pages/cart/cart_page.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/utils/dimentions.dart';
import '/widgets/appIcon.dart';
import '/widgets/bigText.dart';
import '/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecoFoodDetails extends StatelessWidget {
  final int pageId;

  RecoFoodDetails({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecomendedProductsController>()
        .recommendedProductsList[pageId];
    Get.find<PopularProductsController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      ///ROUTE
                      Get.back();
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductsController>(builder: (controller) {
                  return InkWell(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(RouteHelpler.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart),
                        Get.find<PopularProductsController>().totalItems >= 1
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimentions.radius20),
                      topLeft: Radius.circular(Dimentions.radius20),
                    )),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Dimentions.hight10),
                child: Center(
                  child: BigText(size: Dimentions.font26, text: product.name),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.deepOrange,
            //thats a true pickle
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              AppConstants.baseUrl + "/uploads/" + product.img,
              width: double.maxFinite,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimentions.width20),
              child: ExpandableText(text: product.description),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductsController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimentions.width20 * 2.5,
                    vertical: Dimentions.hight10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.iconSize24,
                      ),
                    ),
                    BigText(
                      text: "\$ ${product.price} " +
                          "x" +
                          controller.inCartItems.toString(),
                      color: AppColors.mainBlackColor,
                      size: Dimentions.font26,
                    ),
                    InkWell(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.iconSize24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    InkWell(
                      onTap: () => controller.addItem(product),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimentions.hight20,
                            horizontal: Dimentions.hight20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                          text: "\$ ${product.price} | add to cart",
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
