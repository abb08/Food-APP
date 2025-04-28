import 'package:ecoomerce_dbestech/pages/address/add_address_page.dart';
import 'package:ecoomerce_dbestech/pages/auth/signIn.dart';
import 'package:ecoomerce_dbestech/pages/auth/sign_up.dart';
import 'package:ecoomerce_dbestech/pages/home/home_page.dart';
import 'package:ecoomerce_dbestech/pages/splash/splash_screen.dart';

import '../pages/cart/cart_page.dart';
import '/pages/food/popfoodDetail.dart';
import '/pages/food/recoFoodDetails.dart';
import '/pages/home/mainFoodPage.dart';
import 'package:get/get.dart';

class RouteHelpler {
  static const String home = "/";
  static const String splashPage = "/splash_page";
  static const String popularFood = "/popular_food";
  static const String recommendedFood = "/recommended_food";
  static const String cartPage = "/cart_page";
  static const String signIn = "/sign_in";
  static const String signUp = "/sign_up";
  static const String address = "/address";



  static String getSplashScreen() => '$splashPage';
  static String getInitial() => '$home';
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static String getCartPage() => '$cartPage';
  static String getSignInPage()=> '$signIn';
  static String getSignUpPage() => '$signUp';
  static String getAddresssPage() => '$address';


  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () {
        return SplashScreen();//HomePage();
      },
    ),
    GetPage(
      name: home,
      page: () {
        return HomePage();//HomePage();
      },
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopFoodDetail(pageId: int.parse(pageId!));
      },
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecoFoodDetails(pageId: int.parse(pageId!));
      },
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
      name: signIn,
      page: () {
        return SignIn();//HomePage();
      },
    ),GetPage(
      name: signUp,
      page: () {
        return SignUp();//HomePage();
      },
    ),
    GetPage(
      name: address,
      page: () {
        return AddAddressPage();//HomePage();
      },
    ),
  ];
}
