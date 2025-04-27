import 'package:ecoomerce_dbestech/controllers/auth_controller.dart';
import 'package:ecoomerce_dbestech/controllers/popularProductsController.dart';
import 'package:ecoomerce_dbestech/controllers/recomendedController.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/widgets/showCustomSnachBar.dart';

import '/controllers/cart_controller.dart';
import '/pages/home/mainFoodPage.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/utils/dimentions.dart';
import '/widgets/appIcon.dart';
import '/widgets/bigText.dart';
import '/widgets/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimentions.hight20,
                left: Dimentions.width20,
                right: Dimentions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: AppColors.mainColor,
                        size: Dimentions.iconSize24 * 2,
                      ),
                    ),
                    SizedBox(
                      width: Dimentions.width20 * 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => MainFoodPage());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: AppColors.mainColor,
                        size: Dimentions.iconSize24 * 2,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: AppColors.mainColor,
                      size: Dimentions.iconSize24 * 2,
                    ),
                  ],
                )),
            Positioned(
              top: Dimentions.hight20 * 5,
              left: Dimentions.width20,
              right: Dimentions.width20,
              bottom: 0,
              child: Container(
                // margin: EdgeInsets.only(top: Dimentions.hight10),

                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (controller) {
                        var _carList = controller.getItems;

                        return ListView.builder(
                            itemCount: _carList.length,
                            itemBuilder: (_, index) {
                              // int _total= int.parse(_carList[index].price.toString)  (_carList[index].quantity) ;
                              return Container(
                                height: Dimentions.hight20 * 5,
                                width: double.infinity,
                                margin:
                                    EdgeInsets.only(bottom: Dimentions.hight10),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        var popindex = Get.find<
                                                PopularProductsController>()
                                            .popularProductsList
                                            .indexOf(_carList[index].product);
                                        if (popindex >= 0) {
                                          Get.toNamed(
                                              RouteHelpler.getPopularFood(
                                                  popindex));
                                        } else {
                                          var recoindex = Get.find<
                                                  RecomendedProductsController>()
                                              .recommendedProductsList
                                              .indexOf(_carList[index].product);
                                          Get.toNamed(
                                              RouteHelpler.getRecommendedFood(
                                                  recoindex));
                                        }
                                      },
                                      child: Container(
                                        height: Dimentions.hight20 * 5,
                                        width: Dimentions.hight20 * 5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimentions.radius20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(AppConstants
                                                      .baseUrl +
                                                  "/uploads/" +
                                                  controller.getItems[index].img
                                                      .toString()),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimentions.width10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: Dimentions.hight20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: controller
                                                  .getItems[index].name!,
                                              color: Colors.black45,
                                            ),
                                            SmallText(text: 'Spicy'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: "\$ " +
                                                      _carList[index]
                                                          .price
                                                          .toString(),
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          Dimentions.hight10,
                                                      horizontal:
                                                          Dimentions.hight10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimentions
                                                                .radius15),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller.addItem(
                                                              _carList[index]
                                                                  .product!,
                                                              -1);
                                                          //    popBuilder.setQuantity(false);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimentions.width10 /
                                                                2,
                                                      ),
                                                      BigText(
                                                          text: _carList[index]
                                                              .quantity
                                                              .toString()),
                                                      //popBuilder.inCartItems.toString()),
                                                      SizedBox(
                                                        width:
                                                            Dimentions.width10 /
                                                                2,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          controller.addItem(
                                                              _carList[index]
                                                                  .product!,
                                                              1);
                                                          //popBuilder.setQuantity(true);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    )),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
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
                  child: BigText(
                      text: "\$ " + cartController.totalAmount.toString()),
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
                      //CartController.;
                      if (Get.find<AuthController>().isUserLoggedIn()) {
                        cartController.addHisrory();
                        print("check out sucess");
                      } else {
                        showCustomSnackBar("u need to sign in first");
                        Get.toNamed(RouteHelpler.getSignInPage());
                      }
                    },
                    child: BigText(
                      text: "check out",
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
