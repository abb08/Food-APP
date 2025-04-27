import 'package:ecoomerce_dbestech/models/products_model.dart';

class Cart {
  int? _totalSize;
  int? _typeId;
  int? _offset;

  late List<CartModel> _products;

  List<CartModel> get products => _products;

  Cart({required totalSize,
    required typeId,
    required offset,
    required products}) {
    _typeId = typeId;
    _totalSize = totalSize;
    _products = products;
    _offset = offset;
  }
//this method isnt used until now 19jan we just use the model methods
  Cart.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <CartModel>[];
      json['products'].forEach((v) {
        _products.add(CartModel.fromJson(v));
      });
    }
  }
}

class CartModel {
  int? id;
  String? name;
  int? quantity;
  bool? isExest;
  String? time;
  int? price;
  ProductModel? product;
  String? img;

  CartModel({
    this.product,
    this.id,
    this.quantity,
    this.isExest,
    this.time,
    this.name,
    this.price,
    this.img,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];

    isExest = json['isExest'];
    time = json['time'];
    quantity = json['quantity'];
    product = ProductModel.fromJson(json['product']);
  }

  //notice that tojson is the opposite of from json
  //this is the method that makes converting this structure to json possible
  //they have to be identical so u can convert to and from it and without Null exeption like this
  //type 'Null' is not a subtype of type 'Map<String, dynamic>'
  //its because a missing element will return null
  Map<String, dynamic> toJson() {
    return {'id': this.id,
      'name': this.name,
      'price': this.price,
      'img': this.img,
      'isExest': this.isExest,
      'time': this.time,
      'quantity': this.quantity,
      //before adding the product u should add tojson method in product model
      'product': this.product!.toJson(),
    };
  }
}