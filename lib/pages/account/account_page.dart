import 'package:ecoomerce_dbestech/controllers/auth_controller.dart';
import 'package:ecoomerce_dbestech/controllers/cart_controller.dart';
import 'package:ecoomerce_dbestech/controllers/userController.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/accountItem.dart';
import 'package:ecoomerce_dbestech/widgets/appIcon.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if (_isUserLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("user logged innnn");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "account",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (controller) {
        return _isUserLoggedIn
            ? (controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: Dimentions.hight20),
                    child: Column(
                      children: [
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimentions.hight45 + Dimentions.hight30,
                          size: Dimentions.hight15 * 10,
                        ),
                        SizedBox(
                          height: Dimentions.hight20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AccountItem(
                                    text: controller.userModel.name,
                                    icon: Icons.person,
                                    backgorundColor: AppColors.mainColor),
                                AccountItem(
                                    text: controller.userModel.phone,
                                    icon: Icons.phone,
                                    backgorundColor: AppColors.yellowColor),
                                AccountItem(
                                    text: controller.userModel.email,
                                    icon: Icons.mail,
                                    backgorundColor: AppColors.yellowColor),
                                AccountItem(
                                    text: "fill in your address",
                                    icon: Icons.pin_drop,
                                    backgorundColor: AppColors.yellowColor),
                                AccountItem(
                                    text: "message",
                                    icon: Icons.message_outlined,
                                    backgorundColor: Colors.red),
                                InkWell(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .isUserLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedPrefrences();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      //  Get.offNamed(RouteHelpler.getSignInPage());
                                      print("logged out");
                                    } else {
                                      print("ur already logged out");
                                    }
                                  },
                                  child: AccountItem(
                                      text: "log out",
                                      icon: Icons.logout_outlined,
                                      backgorundColor: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Dimentions.hight20 * 10,
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimentions.hight20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/image/signintocontinue.png"),
                            fit: BoxFit.contain)),
                  ),
                  Container(
                    color: AppColors.mainColor,
                    child: Center(
                      child: Text(
                        "You need to Sign in first",
                        style: TextStyle(fontSize: Dimentions.font20),
                      ),
                    ),
                  )
                ],
              );
      },
      ),
    );
  }
}
