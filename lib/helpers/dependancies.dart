import 'package:ecoomerce_dbestech/controllers/auth_controller.dart';
import 'package:ecoomerce_dbestech/controllers/locationController.dart';
import 'package:ecoomerce_dbestech/controllers/userController.dart';
import 'package:ecoomerce_dbestech/data/repositoreis/auth_repo.dart';
import 'package:ecoomerce_dbestech/data/repositoreis/location_repo.dart';
import 'package:ecoomerce_dbestech/data/repositoreis/user_repo.dart';

import '/controllers/cart_controller.dart';
import '/controllers/popularProductsController.dart';
import '/data/api/api_client.dart';
import '/data/repositoreis/cartRepo.dart';
import '/data/repositoreis/popPorductRepo.dart';
import '/utils/constants.dart';
import 'package:get/get.dart';
import '../controllers/recomendedController.dart';
import '../data/repositoreis/recomendedRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  //shared pref
  final sharedPrefrences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPrefrences);

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl,sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
//repo
  Get.lazyPut(() => PopularProDuctRepo(apiClient: Get.find()),fenix:true);
  Get.lazyPut(() => RecomendedProDuctRepo(apiClient: Get.find()),fenix:true);
  Get.put(CartRepo(sharedPreferences: Get.find()), permanent: true);
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(sharedPrefrences: Get.find(), apiClient: Get.find()));

  //controller
  Get.lazyPut(
          () => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductsController(popularProDuctRepo: Get.find()));
  Get.lazyPut(
      () => RecomendedProductsController(recomendedProDuctRepo: Get.find()));
  Get.put(CartController(cartRepo: Get.find()), permanent: true);
  Get.put(UserController(userRepo: Get.find(),), permanent: true);
  Get.put(LocationController(locationRepo: Get.find()), permanent: true);
}
