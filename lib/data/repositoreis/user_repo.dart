import 'package:ecoomerce_dbestech/data/api/api_client.dart';
import 'package:ecoomerce_dbestech/utils/constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.userInfoUri);
  }
}
