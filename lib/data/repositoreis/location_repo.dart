import 'package:ecoomerce_dbestech/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecoomerce_dbestech/models/addressModel.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPrefrences;

  LocationRepo({required this.sharedPrefrences, required this.apiClient});

  Future<Response> getAddressFromGoogle(LatLng latlng) async {
    /*
    for debugging
    print('.////////////////////${latlng.latitude}//${latlng.longitude}');

Response xx= await apiClient.getData('${AppConstants.geoCodeUri}'
    '?lat=${latlng.latitude}&lng=${latlng.longitude}');
print(xx.body["results"][0]['formatted_address'].toString());*/
    return await apiClient.getData('${AppConstants.geoCodeUri}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}');

    //xx;
  }

  String getUserAddress() {
//see the null safety ^-^
    return sharedPrefrences.getString(AppConstants.userAddress) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstants.addUserAddress, addressModel.toJson());
  }

  Future<Response> getAddressList() async {
    return await apiClient.getData(AppConstants.addressListUri);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    //so if user if changed the token is updated
    //and no its updated locally in the header saved here
    apiClient.updateHeader(sharedPrefrences.getString(AppConstants.token)!);

//save data
    return await sharedPrefrences.setString(
        AppConstants.userAddress, userAddress);
  }

  ///gets the zone of selected location and if it has service in it
  Future<Response> getZone(String lat, String long) async {
    /*
  for debugging
  print('lat:$lat------------lang:$long');

    Response x=  await apiClient
        .getData("${AppConstants.zoneUri}?lat=$lat&lng=$long");

    print("XXXXXXXXXXXXXXXXXXXXX ${x.body.toString()}");
 */
    return await apiClient
        .getData("${AppConstants.zoneUri}?lat=$lat&lng=$long");

    //x;
  }

  Future<Response> searchLocation(String text) async {
    return apiClient
        .getData('${AppConstants.searchLocationUri}?search_text=$text');
  }
  Future<Response> setLocation(String placeId) async {
    return apiClient
        .getData('${AppConstants.placeDetailsUri}?placeid=$placeId');
  }
}
