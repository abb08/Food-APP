
//old check quantity
/*

*
 int checkQuantity(int quan) {
  int totalQuantity = _inCartItems + quan; // Calculate the total quantity

  if (totalQuantity < 0) {
    Get.snackbar("Item count", "You can't reduce more",
        backgroundColor: AppColors.mainColor, colorText: Colors.white);
    return _inCartItems > 0 ? -_inCartItems : 0; // Prevent negative values
  } else if (totalQuantity > 20) {
    Get.snackbar("Item count", "You can't order more",
        backgroundColor: AppColors.mainColor, colorText: Colors.white);
    return 20 - _inCartItems; // Limit the added quantity
  } else {
    return quan; // Return the valid quantity
  }
}

* */