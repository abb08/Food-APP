import 'dart:convert';

class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.id,
    required this.phone,
    required this.email,
    required this.orderCount,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        orderCount: json["order_count"],
        name: json["f_name"]);
  }
}
