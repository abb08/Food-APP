import 'package:ecoomerce_dbestech/data/api/api_client.dart';
import 'package:ecoomerce_dbestech/data/repositoreis/location_repo.dart';
import 'package:ecoomerce_dbestech/models/addressModel.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController implements GetxService {
//final ApiClient apiClient;
  LocationRepo locationRepo;
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ['home', 'office', 'others'];
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAdress;
List get addressList => _addressList;
  Map get getAddress => _getAdress;

  LocationController({required this.locationRepo});
}
