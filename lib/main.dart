import 'package:ecoomerce_dbestech/controllers/cart_controller.dart';
import 'package:ecoomerce_dbestech/pages/auth/signIn.dart';
import 'package:ecoomerce_dbestech/pages/auth/sign_up.dart';

import '/controllers/popularProductsController.dart';
import '/routes/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/onLandscape.dart';
import 'controllers/recomendedController.dart';
import 'helpers/dependancies.dart'as dep;
Future<void> main() async {
  Get.put(OrientationController());
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
// tut 2 1:51:00 moves this two to the splash screen for convieniance
  /// the lazypot is not deleted cause its called on the root so its never discarded really
    //this get,find.method is handy if u want a method to get triggered as soon as the app starts
      Get.find<CartController>().getCartData();
    Get.find<PopularProductsController>().getPopularProductsList();
    Get.find<RecomendedProductsController>().getRecommendedProductsList();
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
    //  home:SignIn() ,
      initialRoute: RouteHelpler.getSplashScreen(),
        getPages: RouteHelpler.routes,

    ) ;
  }
}

