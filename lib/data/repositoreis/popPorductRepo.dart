import '/data/api/api_client.dart';
import '/utils/constants.dart';
import 'package:get/get.dart';


class PopularProDuctRepo extends GetxService {
  final ApiClient apiClient;
PopularProDuctRepo({required  this.apiClient});


  Future<Response> getPopularProductList()async{
return await apiClient.getData(AppConstants.popularProductUri);

  }


}