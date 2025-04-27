import '/controllers/cart_controller.dart';
import '/data/repositoreis/popPorductRepo.dart';
import '/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopularProductsController extends GetxController {
  final PopularProDuctRepo popularProDuctRepo;

  List<dynamic> _popularProductsList = [];

  List<dynamic> get popularProductsList =>
      _popularProductsList; // cause u dont wanna dy=urectly access the privet one from outside

  PopularProductsController({required this.popularProDuctRepo});

  bool _isLoaded = false;
  late CartController _cart;

  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductsList() async {
    Response response = await popularProDuctRepo.getPopularProductList();
    if (response.statusCode == 200) {
      //print("got products");
      _popularProductsList = []; // u empty it so no left over from previus ops
      _popularProductsList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool increment) {
    if (increment) {
      print("_quantity +"+_quantity.toString());
      print("incart items +"+inCartItems.toString());
      _quantity = checkQuantity(_quantity + 1);
      update();
    } else {
      print("_quantity -"+_quantity.toString());
      print("incart items -"+inCartItems.toString());
      _quantity = checkQuantity(_quantity - 1);
      update();
    }
  }

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

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
  //  print("exits?" + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    //print("quantity in cart " + _inCartItems.toString());
    //update(); --though i thought this to be the logicall thing it arraised a runtime error and without it the code functions just as well
//if exist in the storage
    //get from storage _inCartItems
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
    _cart.items.forEach((key, value) {
    /*  print("the id is " +
          value.id.toString() +
          " the quantity is " +
          value.quantity.toString());
    */
    });
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}


//old checkquantity in trash can