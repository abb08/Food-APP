import 'package:ecoomerce_dbestech/controllers/auth_controller.dart';
import 'package:ecoomerce_dbestech/models/sign_up_body.dart';
import 'package:ecoomerce_dbestech/pages/auth/signIn.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/appTextFiled.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecoomerce_dbestech/widgets/showCustomSnachBar.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passowrdController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    const signUpImages = [
      "assets/image/t.png",
      "assets/image/f.png",
      "assets/image/g.png",
    ];
    void registeration(AuthController authController) {

      String email = emailController.text
          .trim(); //text so u can assign a controller to a string and trim takes out the spaces if u want to
      String passowrd = passowrdController.text.trim();
      String phone = phoneController.text.trim();
      String name = nameController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: 'name');
        GetSnackBar(
          message: "Type in your name",
          title: 'name',
        );
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "phone number");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email", title: 'email');
      } else if (passowrd.isEmpty) {
        showCustomSnackBar("password can't be empty", title: 'password');
      } else if (passowrd.length < 6) {
        showCustomSnackBar("password can't be less than 6 characters",
            title: 'password');
      } else {
        SignUpBody signUpBody = SignUpBody(
            email: email, name: name, phone: phone, password: passowrd);
      //  showCustomSnackBar("all went well !!", title: 'perfect');
            authController.registeration(signUpBody).then((status){
        if(status.isSuccess){


        }else{
          showCustomSnackBar(status.message.toString());
        }

      });
      }
    }

    return GetBuilder<AuthController>(builder: (_controller){
      return  Scaffold(
        backgroundColor: Colors.white,
        body:!_controller.isLoading? SingleChildScrollView(
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
              Apptextfiled(
                  textController: emailController,
                  icon: Icons.email,
                  hintText: "Email"),
              Apptextfiled(
                isUpsecue: true,
                  textController: passowrdController,
                  icon: Icons.password,
                  hintText: "Password"),
              Apptextfiled(
                  textController: phoneController,
                  icon: Icons.phone_android_rounded,
                  hintText: "Phone"),
              Apptextfiled(
                  textController: nameController,
                  icon: Icons.person,
                  hintText: "Name"),
              SizedBox(
                height: Dimentions.hight20,
              ),
              InkWell(
                onTap: () {
                  registeration(_controller);
              //    Get.offNamed(RouteHelpler.getInitial());
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
                      text: "Sign Up",
                      color: Colors.white,
                      size: Dimentions.font20 + Dimentions.font20 / 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimentions.hight10,
              ),
              RichText(
                text: TextSpan(
                    text: "already have an account?!",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(SignIn()), //Get.back
                    style: TextStyle(
                        color: Colors.grey, fontSize: Dimentions.font20)),
              ),
              SizedBox(
                height: Dimentions.hight20,
              ),
              BigText(
                text: "Sign up using one of the following methods",
                size: Dimentions.font16,
                color: Colors.grey,
              ),
              Wrap(
                children: List.generate(
                  3,
                      (index) => Padding(
                    padding: EdgeInsets.all(Dimentions.hight10),
                    child: CircleAvatar(
                      radius: Dimentions.radius30,
                      backgroundImage: AssetImage(signUpImages[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator(),),
      );

    });
  }
}
