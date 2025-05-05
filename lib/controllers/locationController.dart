import 'dart:convert';

import 'package:ecoomerce_dbestech/data/api/api_client.dart';
import 'package:ecoomerce_dbestech/data/repositoreis/location_repo.dart';
import 'package:ecoomerce_dbestech/models/addressModel.dart';
import 'package:ecoomerce_dbestech/models/responseModel.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
//final ApiClient apiClient;
  LocationRepo locationRepo;
  bool _loading = false;
  bool _changAddress = true;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];

  late List<AddressModel> _allAddressList;

  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ['home', 'office', 'others'];

  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;

  int get addressTypeIndex => _addressTypeIndex;

  Placemark get placemark => _placemark;

  List get addressList => _addressList;

  Position get position => _position;

  Position get pickPosition => _pickPosition;

  bool get loading => _loading;

  bool _updateAddressData = true;

  /*
  * zone stuff*/
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _buttonDisabled = true;

  bool get buttonDisabled => _buttonDisabled;
  bool _inZone = false;

  bool get inZone => _inZone;

  LocationController({required this.locationRepo});

  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePostion(CameraPosition updatePosition, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        //if ur tryimg to set it from the address page or the other page
        if (fromAddress) {
          _position = Position(
              longitude: updatePosition.target.longitude,
              latitude: updatePosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: updatePosition.target.longitude,
              latitude: updatePosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changAddress) {
          String address = await getAddressFromGoogle(LatLng(
              updatePosition.target.latitude, updatePosition.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: address)
              : _pickPlacemark = Placemark(name: address);
        }
        ResponseModel _responseModel = await getZone(
            updatePosition.target.latitude.toString(),
            updatePosition.target.longitude.toString(),
            false);
        _buttonDisabled = !_responseModel.isSuccess;
      } catch (e) {
        print("trouble in paradies" + e.toString());
      }
    } else {
      _updateAddressData = true;
      //this var is useless if u ask me but what do i know
    }
    //print("=============${placemark.name.toString()}");
    _loading = false;
    update();
  }

  Future<String> getAddressFromGoogle(LatLng latlang) async {
    String _addrees = 'location UnKnown';
    Response response = await locationRepo.getAddressFromGoogle(latlang);
    if (response.body["status"] == "OK") {
      _addrees = response.body["results"][0]['formatted_address'].toString();
     } else {
      print("trouble gettin google location from server");
    }

    return _addrees;
  }

  late Map<String, dynamic> _getAdress;

  Map get getAddress => _getAdress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    //since its a map but ur getting a string then u need to decode it
    _getAdress = jsonDecode(locationRepo.getUserAddress());
    try {
      //why not just use _getAddress ??!
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    ResponseModel responseModel;
    Response response = await locationRepo.addAddress(addressModel);

    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("could't save user data");
      responseModel = ResponseModel(
          false,
          response.statusText != null
              ? response.body.toString()!
              : "statusText empty");
    }
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAddressList();
    if (response.statusCode == 200) {
      //=[],,so if its a diffrent user it doesn't get mixed
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    //shared pref only accept string so u need to encode it as json [jsonEncode]and for that u need to make sure its json =>.tojson
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  getUserAddreaaFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(
      String lat, String lang, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();

    Response response = await locationRepo.getZone(lat, lang);
    if (response.statusCode == 200) {
      _inZone = true;
      //its a dummy from backend the real is
      // (true, response.body['zone-id'.toString])
      //but server 500 so were improvising
      _responseModel = ResponseModel(true, response.body.toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true,
          response.statusText ?? "status text is somehow Null check backend");
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();

    return _responseModel;
  }
}
