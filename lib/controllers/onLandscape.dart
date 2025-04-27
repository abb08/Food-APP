import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrientationController extends GetxController with WidgetsBindingObserver {
  var screenHeight = 0.0.obs;
  var screenWidth = 0.0.obs;
  var isLandscape = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    updateDimensions(); // Initial values
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    updateDimensions(); // Update dimensions on changes
  }

  void updateDimensions() {
    final window = WidgetsBinding.instance.window;
    final height = window.physicalSize.height / window.devicePixelRatio;
    final width = window.physicalSize.width / window.devicePixelRatio;

    screenHeight.value = height;
    screenWidth.value = width;
    isLandscape.value = width > height;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
