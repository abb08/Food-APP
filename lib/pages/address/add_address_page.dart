import 'package:ecoomerce_dbestech/controllers/locationController.dart';
import 'package:ecoomerce_dbestech/models/addressModel.dart';
import 'package:ecoomerce_dbestech/pages/address/pickAddressMap.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/appTextFiled.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecoomerce_dbestech/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:ecoomerce_dbestech/controllers/userController.dart';
import 'package:ecoomerce_dbestech/controllers/locationController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:ecoomerce_dbestech/controllers/userController.dart';

import '../../widgets/appIcon.dart';

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
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().isUserLoggedIn();

    // if he's logged in but u didnt get the info then go get it
    if (_isLogged && Get.find<UserController>().userModel == null) {
      ///todo:hehe good luck

      Get.find<UserController>().getUserInfo();
      //if user has a saved location aka not first time then get it

      if (Get.find<LocationController>().addressList.isNotEmpty) {
        //
        if (Get.find<LocationController>().getUserAddreaaFromLocalStorage() ==
            "") {
          Get.find<LocationController>()
              .saveUserAddress(Get.find<LocationController>().addressList.last);
        }
        //
        Get.find<LocationController>().getUserAddress();
        _cameraPosition = CameraPosition(
            target: LatLng(
                double.parse(
                    Get.find<LocationController>().getAddress['latitude']),
                double.parse(
                    Get.find<LocationController>().getAddress['longitude'])));

        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel.name}';
          _contactPersonNumber.text = '${userController.userModel.phone}';
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            //since getUserAddress returns a model u can access its data one by one
            Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          //remember the null safety ??
          _addressController.text = '${locationController.placemark.name ?? ""}'
              '${locationController.placemark.country ?? ""}'
              '${locationController.placemark.postalCode ?? ""}'
              '${locationController.placemark.locality ?? ""}';

          //SingleChildScrollView: so when u use the keyboard it doesnt overflow
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Address page"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 180,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors.mainColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: _initialPosition,
                                zoom: 17,
                              ),
                              onTap: (latlang) {
                                Get.toNamed(RouteHelpler.getPickAddressMap(),
                                    arguments: PickAddressMap(
                                      fromAddress: true,
                                      fromSignUp: false,
                                      googleMapController: locationController.mapController,

                                    ));
                              },
                              // mapType: MapType.normal,
                              // myLocationEnabled: true,
                              //myLocationButtonEnabled: false,
                              indoorViewEnabled: false,
                              mapToolbarEnabled: false,
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              myLocationEnabled: true,
                              onCameraMove: (position) =>
                                  _cameraPosition = position,
                              onCameraIdle: () {
                                locationController.updatePostion(
                                    _cameraPosition, true);
                              },
                              onMapCreated: (GoogleMapController controller) {
                                locationController.setMapController(controller);
                              },
                            ),
                          ],
                        )),
                    SizedBox(
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimentions.hight10,
                              top: Dimentions.hight10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        locationController
                                            .setAddressTypeIndex(index);
                                      },
                                      child: Container(
                                        height: Dimentions.hight30 * 2,
                                        width: Dimentions.hight30 * 2,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimentions.radius20 / 4),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                color: Colors.grey[500]!)
                                          ],
                                        ),
                                        child: Icon(
                                          index == 0
                                              ? Icons.home_filled
                                              : index == 1
                                                  ? Icons.work
                                                  : Icons.location_on,
                                          color: locationController
                                                      .addressTypeIndex ==
                                                  index
                                              ? AppColors.mainColor
                                              : Theme.of(context).disabledColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimentions.hight10,
                                    )
                                  ],
                                );
                              }),
                        )),
                    SizedBox(
                      height: Dimentions.hight20,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: Dimentions.hight20),
                        child: BigText(text: 'delivery location')),
                    SizedBox(
                      height: Dimentions.hight10 / 2,
                    ),
                    Apptextfiled(
                        textController: _addressController,
                        icon: Icons.map,
                        hintText: "delivery location"),
                    SizedBox(
                      height: Dimentions.hight10 / 2,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: Dimentions.hight20),
                        child: BigText(text: 'Name')),
                    Apptextfiled(
                        textController: _contactPersonName,
                        icon: Icons.person,
                        hintText: "Name"),
                    Padding(
                        padding: EdgeInsets.only(left: Dimentions.hight20),
                        child: BigText(text: 'phone number')),
                    SizedBox(
                      height: Dimentions.hight10 / 2,
                    ),
                    Apptextfiled(
                        textController: _contactPersonNumber,
                        icon: Icons.phone,
                        hintText: "phone number"),
                    SizedBox(
                      height: Dimentions.hight20,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: Dimentions.bottomHightBar,
                padding: EdgeInsets.only(
                  top: Dimentions.hight30,
                  bottom: Dimentions.hight30,
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20 * 2),
                    topRight: Radius.circular(Dimentions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                          address: _addressController.text,
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                        );
                        locationController
                            .addAddress(_addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            Get.offNamed(RouteHelpler.getInitial());
                            Get.snackbar("address", "added successfully");
                          } else {
                            Get.snackbar("address", "couldn't add address");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimentions.hight20,
                            horizontal: Dimentions.hight20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                            text: " save address",
                            color: Colors.white,
                            size: Dimentions.font20 * 1.4),
                      ),
                    )
                  ],
                ),
              ));
        });
      },
    );
  }
}
