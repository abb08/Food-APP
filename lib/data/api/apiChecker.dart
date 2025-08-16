import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/widgets/showCustomSnachBar.dart';
import 'package:get/get.dart';
class ApiChecker{
static void checkApi(Response response){
  if(response.statusCode==401){
    Get.offNamed(RouteHelpler.getSignInPage());
  }else{
    showCustomSnackBar(response.statusText!);
  }
}

}