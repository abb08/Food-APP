import 'package:ecoomerce_dbestech/controllers/locationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecoomerce_dbestech/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:ecoomerce_dbestech/controllers/userController.dart';
import 'package:ecoomerce_dbestech/controllers/locationController.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
  CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition=LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().isUserLoggedIn();

  // if he's logged in but u didnt get the info then go get it
    if (_isLogged&& Get
        .find<UserController>()
        .userModel == null ) {
      ///todo:hehe good luck


      Get.find<UserController>().getUserInfo();
     //if user has a saved location aka not first time then get it

      if (Get
          .find<LocationController>()
          .addressList
          .isNotEmpty) {
        _cameraPosition = CameraPosition(target: LatLng(double.parse(Get
            .find<LocationController>()
            .getAddress['latitude']), double.parse(Get
            .find<LocationController>()
            .getAddress['longitude'])));

_initialPosition=  LatLng(double.parse(Get
    .find<LocationController>()
    .getAddress['latitude']), double.parse(Get
    .find<LocationController>()
    .getAddress['longitude']));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Address page"),),
      body: Column(
        children: [
          Container(
            height: 140,
            margin: EdgeInsets.only(left: 5,right: 5,top: 5),
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,color: Theme.of(context).primaryColor,
              )
            ),
            child: GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 17)),
          )
        ],
      ),
    );
  }
}
