import 'package:ecoomerce_dbestech/pages/auth/sign_up.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/appIcon.dart';
import 'package:ecoomerce_dbestech/widgets/appTextFiled.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/showCustomSnachBar.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passowrdController = TextEditingController();
    void _signIn(AuthController authController) {

      String email = emailController.text
          .trim(); //text so u can assign a controller to a string and trim takes out the spaces if u want to
      String passowrd = passowrdController.text.trim();
        if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email", title: 'email');
      } else if (passowrd.isEmpty) {
        showCustomSnackBar("password can't be empty", title: 'password');
      } else if (passowrd.length < 6) {
        showCustomSnackBar("password can't be less than 6 characters",
            title: 'password');
      } else {

        //showCustomSnackBar("all went well !!", title: 'perfect');
        authController.logIn(email,passowrd).then((status){
          if(status.isSuccess){
Get.toNamed(RouteHelpler.getInitial());
          }else{
            showCustomSnackBar(status.message.toString());
          }

        });
      }
    }





    return GetBuilder<AuthController>(builder: (_controller){
      return Scaffold(
        backgroundColor: Colors.white,
        body: _controller.isLoading?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimentions.screenHight * 0.05,
              ),
              Container(
                height: Dimentions.screenHight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    radius: Dimentions.hight20 * 4,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/image/logo part 1.png"),
                  ),
                ),
              ),
              //hello welcome
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal:Dimentions.hight20, ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "Hello",
                      size: Dimentions.font20 *3+ Dimentions.font20 / 2,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey, fontSize: Dimentions.font20)),
                    ),
                  ],
                ),
              ),
              Apptextfiled(
                  textController: emailController,
                  icon: Icons.email,
                  hintText: "Email"),
              Apptextfiled(
                  isUpsecue: true,
                  textController: passowrdController,
                  icon: Icons.password,
                  hintText: "Password"),
              Padding(
                padding: EdgeInsets.only(right: Dimentions.hight30,top: Dimentions.hight10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey, fontSize: Dimentions.font20*1.1)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimentions.hight20 * 4,
              ),
              InkWell(
                onTap: () {
                  
_signIn(_controller);
                },
                child: Container(
                  height: Dimentions.screenHight / 13,
                  width: Dimentions.screenWidth / 2,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimentions.radius30),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      color: Colors.white,
                      size: Dimentions.font20 + Dimentions.font20 / 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimentions.hight45,
              ),
              RichText(
                text: TextSpan(
                    text: "Don't have an account yet?!  ",
                    style: TextStyle(
                        color: Colors.grey, fontSize: Dimentions.font20),
                    children: [
                      TextSpan(
                          text: "Create",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(SignUp()),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimentions.font20,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ],
          ),
        ),
      );
    });


  }
}
