class AppConstants {
  static const String appName ="hehe";
  static const String appVersion ="1";//10.0.2.2:8000
  static const String baseUrl ="http://192.168.70.195:8000";
 // u can try 10.0.2.2:8000 or 127.0.0.1:8000 for local since the current one only works with php artisan serve --host=0.0.0.0 --port=8000
  //this for the local laravel host//"http://mvs.bslmeiyu.com"; this one for the first part and its working
  static const String popularProductUri ="/api/v1/products/popular";
  static const String recommendedProductUri ="/api/v1/products/recommended";
  static const String drinksUri ="/api/v1/products/drinks";
  static const String token ="  ";
  static const String cartList ="Cart-list";
  static const String cartHistoryList ='cart-history-list';
  static const String userAddress ="user_address";
//auth end points
  static const String registerationUri ="/api/v1/auth/register";
  static const String geoCodeUri ="/api/v1/config/geocode-api";
  static const String zoneUri ="/api/v1/config/get-zone-id";
  static const String searchLocationUri ="/api/v1/config/place-api-autocomplete";
  static const String placeDetailsUri ="/api/v1/config/place-api-details";

  static const String loginUri ="/api/v1/auth/login";
  static const String addUserAddress ="/api/v1/customer/address/add";
  static const String addressListUri ="/api/v1/customer/address/list";
  static const String userInfoUri ="/api/v1/customer/info";

  static const String phone ="";
  static const String password ="";

}