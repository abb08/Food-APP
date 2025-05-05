import '/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ApiClient extends GetConnect implements GetxService {
  late String token ;
  late final appBaseUrl;
late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl,required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token=sharedPreferences.getString(AppConstants.token)??"";
    _mainHeaders = {
      "content-type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
  }

  void updateHeader(String token) {
    // to update the  token in the header after it's changed

    _mainHeaders = {
      "content-type": "application/json; charset=YTF-8",
     "Authorization": "Bearer $token"   };
  }

  Future<Response> getData(
    String uri,{Map<String,String>? header}
  ) async {
    try {
      Response response = await get(uri,headers: header??_mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      print('tokkkkkkkkkkkkkkkk${_mainHeaders["Authorization"]}');
      Response response = await post(uri, body,
          headers: _mainHeaders); //headers tells the backend what to expect

      return response;
    } catch (e) {
      print(e.toString());

      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
