import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = "error"}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),messageText: Text(message,style: TextStyle(color: Colors.white),),
colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,

  );
}
