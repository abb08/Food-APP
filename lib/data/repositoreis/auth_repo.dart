import 'package:ecoomerce_dbestech/data/api/api_client.dart';
import 'package:ecoomerce_dbestech/models/sign_up_body.dart';
import 'package:ecoomerce_dbestech/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  bool isUserLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.token) ?? "none";
  }

  registeration(SignUpBody signUpbody) async {
    return await apiClient.postData(
        AppConstants.registerationUri, signUpbody.toJsion());
  }

  logIn(String email, String password) async {
    return await apiClient.postData(
        AppConstants.loginUri, {'email': email, 'password': password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<void> saveUserNumberandPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.password, password);
      await sharedPreferences.setString(AppConstants.phone, number);
    } catch (e) {
      throw (e);
    }
  }

  bool clearSharedPrefrences() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.password);
    sharedPreferences.remove(AppConstants.phone);
    apiClient.token='';
    apiClient.updateHeader("");
    return true;
  }
}
