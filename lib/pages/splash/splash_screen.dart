import 'package:ecoomerce_dbestech/controllers/popularProductsController.dart';
import 'package:ecoomerce_dbestech/controllers/recomendedController.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  //its not used here cause ur lazy and ur doing it in main u can see the tut in main to see implemntation
  Future<void>_loadResorces()async{
  await Get.find<PopularProductsController>().getPopularProductsList();
  await Get.find<RecomendedProductsController>().getRecommendedProductsList();
}
  @override
  void initState() {

    super.initState();
    //the .. the first one creats an instant from the class and the second is a method thing just like .toString
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);


    Timer(
      Duration(seconds: 3) ,
      () => Get.offNamed(RouteHelpler.getInitial()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image(width:Dimentions.splashImg,
                      image: AssetImage('assets/image/logo part 1.png')))),
          Center(
              child: Image(width:Dimentions.splashImg,image: AssetImage('assets/image/logo part 2.png'),),),
        ],
      ),
    );
  }
}
