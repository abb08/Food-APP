import '/data/repositoreis/cartRepo.dart';
import '/models/cart_model.dart';
import '/models/products_model.dart';
import '/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  //just to get _items to a global variable items for print and testing purposes but of no real use
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    //print("the length of the list is" + _items.length.toString());
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          quantity: value.quantity! + quantity,
          isExest: true,
          time: DateTime.now().toString(),
          name: value.name,
          price: value.price,
          img: value.img,
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          print("adding item now from cart controller " +
              product.id.toString() +
              ' quantity' +
              quantity.toString());
          return CartModel(
            id: product.id,
            quantity: quantity,
            isExest: true,
            time: DateTime.now().toString(),
            name: product.name,
            price: product.price,
            img: product.img,
            product: product,
          );
        });
      } else {
        Get.snackbar("item count", "u cant add 0 items",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

// a get method is a method that doesnt take input but returns an out put its just a short cut so u dont use the () i guess thats the getter
  int get totalItems {
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

// this method is only called once when we start the app to upload from the locall storage
  List<CartModel> getCartData() {
    /*
    * so
    the setter gets the cart list from the cart controller
    * stores it in storage items which is in the setter below
    finlly u return the storage items*/
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  //setter or set is opposite to get u have to take imput and s
  set setCart(List<CartModel> items) {
    storageItems = items;
/*
_items is a map not a list so it doesnt have for each thats why u need to do it manually
basically u check if the item is there by its id if its not u put it
*/
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addHisrory() {
    //i still dont know why we made it in the repo not here not but called it here
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};//empty the map
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
}

}
