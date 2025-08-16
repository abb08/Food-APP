import 'package:ecoomerce_dbestech/controllers/locationController.dart';
import 'package:ecoomerce_dbestech/pages/address/wedgits/searchLocationPage.dart';
import 'package:ecoomerce_dbestech/routes/routes_helper.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;

  //see the ? so its nullable so its not required in the constructor no more
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {super.key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late CameraPosition _cameraPosition;
  late GoogleMapController _mapController;

  @override
  void initState() {
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    //can't zoom in
                    /*
                  * on cameraMove capture the position to update it
                  * it throws cameraposition so u have to catch it as input to the function
                  * on camera idle on the other hand doesnt throw anything so it has to be after the oncamera move so u can capture
                  * or steal that location and do what u want
                  * */

                    onCameraMove: (position) => _cameraPosition = position,
                    onCameraIdle: () {
                      locationController.updatePostion(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _mapController =
                          controller; //make sure that its initiated before passing it to the next page
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            'assets/image/pick_marker.png',
                            height: 50,
                            width: 50,
                          )
                        : CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimentions.hight45,
                    right: Dimentions.width20,
                    left: Dimentions.width20,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimentions.width10),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius20 / 2),
                        color: AppColors.mainColor,
                      ),
                      child: InkWell(
                        //notice that u can make a page as custom dialogue
                        onTap: () => Get.dialog(LoactionDialogue(
                          mapController: _mapController,
                        ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              color: AppColors.yellowColor,
                            ),
                            Expanded(
                              child: Text(
                                locationController.pickPlacemark.name ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimentions.font16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(),
                            Icon(
                              Icons.search,
                              size: 25,
                              color: AppColors.yellowColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimentions.hight20 * 7,
                    left: Dimentions.width20,
                    right: Dimentions.width20,
                    child: locationController.isLoading
                        ? Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Custombutton(
                            buttonText: locationController.inZone
                                ? widget.fromAddress
                                    ? "Pick Address"
                                    : "Pick location"
                                : "Service is not available in this area",
                            onPressed: (locationController.buttonDisabled ||
                                    locationController.loading)
                                ? null
                                : () {
                                    if (locationController.pickPosition != 0 &&
                                        locationController.pickPlacemark.name !=
                                            null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          widget.googleMapController!.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                      target: LatLng(
                                                          locationController
                                                              .pickPosition
                                                              .latitude,
                                                          locationController
                                                              .pickPosition
                                                              .longitude))));
                                          locationController.setAddressData();
                                        }

                                        /*
                     * if u want things updated in the previous page Get.back
                     * is a bad choice things don't get updated or initialized well
                     * */
                                        Get.toNamed(
                                            RouteHelpler.getAddresssPage());
                                      }
                                    }
                                  },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
