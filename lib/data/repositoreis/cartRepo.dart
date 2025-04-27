import 'dart:convert';

import 'package:ecoomerce_dbestech/models/cart_model.dart';
import 'package:ecoomerce_dbestech/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
* i dont know what the repo does but u call it from the controller to use it
i.e make a mathod in controller that is just for calling this method
seems pointless but what do i know */
class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartlist) {
    final time = DateTime.now().toString();
    // sharedPreferences.remove(AppConstants.cartHistoryList);
    // sharedPreferences.remove(AppConstants.cartList);
    cart = [];
/*//this line converts the object to A STRING SO ITS COMPATIBLE with cart since its a list of strings not objects<Cartmodel>
//all of this because shared prefrences only deals with strings
  //so u dont get the error that json couldnt convert object to string
  u go to the model ur using and provide a method that does so
  here its a cart model so the method will be added to cart model
  *
  * */

    cartlist.forEach((element) {
      element.time =
          time; //so u update the time field to the unified time = time of purchase
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.cartList, cart);
    print(sharedPreferences.getStringList(AppConstants.cartList));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
    }

    List<CartModel> cartlist = [];
    /*
    * here is whats happining
    * u have a list of string that u want as a list of object<Cartmodel>
    u go thre each element of them and u add it one by one by makinga afunction in the foreach
    u can either (){ return ;} or ()=> ;its all the same
    * u cant however add to cartlist unless they are in cartmodel format
    * the cartmodel has a method that does so
    * but it only accepts map<> elements wich are dart way of json
    * thats why each elemnt will need to be json decoded then cartmodeled then added
    * */
    carts.forEach((element) {
      cartlist.add(CartModel.fromJson(jsonDecode(element)));
    });
//print('insde cart """""""""""""""" '+ cartlist.toString());
    return cartlist;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((e) {
      return cartListHistory.add(CartModel.fromJson(jsonDecode(e)));
    });
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
//print("history list : "+cartHistory[i]);
    }
    sharedPreferences.setStringList(AppConstants.cartHistoryList, cartHistory);
    removeCart();
    print("the length of history " + getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print("the time ''' " + getCartHistoryList()[j].time.toString());
      print(DateTime.now().toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.cartList);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.cartHistoryList);
  }
}
