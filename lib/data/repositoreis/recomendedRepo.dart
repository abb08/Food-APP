import '/data/api/api_client.dart';
import '/utils/constants.dart';
import 'package:get/get.dart';


class RecomendedProDuctRepo extends GetxService {
  final ApiClient apiClient;
  RecomendedProDuctRepo({required  this.apiClient});


  Future<Response> getRecommendedProductList()async{
    return await apiClient.getData(AppConstants.recommendedProductUri);

  }


}