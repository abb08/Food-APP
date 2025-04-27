import 'package:get/get.dart';

import '../controllers/onLandscape.dart';

class Dimentions {
  static final OrientationController _orientationController = Get.find<OrientationController>();

  static double get screenHight => Get.height;//_orientationController.screenHeight.value;
  static double get screenWidth =>Get.width;//_orientationController.screenWidth.value;//


  // Dynamically calculated values
  static double get pageView => screenHight / 2.64;
  static double get pageViewContainer => screenHight / 3.84;
  static double get pageTextContainer => screenHight / 7.03;

  // Heights
  static double get hight10 => screenHight / 84.4;
  static double get hight15 => screenHight / 56.27;
  static double get hight20 => screenHight / 42.2;
  static double get hight30 => screenHight / 28.13;
  static double get hight45 => screenHight / 18.76;

  // Widths
  static double get width10 => screenWidth / 84.4;
  static double get width15 => screenWidth / 56.27;
  static double get width20 => screenWidth / 42.2;
  static double get width30 => screenWidth / 28.13;
  static double get width45 => screenWidth / 18.76;

  // Font sizes
  static double get font20 => screenHight / 42.2;
  static double get font26 => screenHight / 32.38;
  static double get font16 => screenHight / 52.75;

  // Radii
  static double get radius15 => screenHight / 56.27;
  static double get radius20 => screenHight / 42.2;
  static double get radius30 => screenHight / 28.13;

  // Icon sizes
  static double get iconSize24 => screenHight / 35.17;
  static double get iconSize16 => screenHight / 52.75;

  // List view sizes
  static double get listViewImageSize => screenWidth / 3.25;
  static double get listViewTextSize => screenWidth / 3.9;

  // Food details
  static double get foodImagesize => screenHight / 2.41;

  // Bottom height
  static double get bottomHightBar => screenHight / 6.25;

  // Splash screen
  static double get splashImg => screenHight / 3.375;

  // Orientation
  static bool get isLandscape => _orientationController.isLandscape.value;
}
