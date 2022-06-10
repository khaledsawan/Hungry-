import 'package:shop_delivery_system/Services/model/product_model.dart';

class CartModle {
  int? id;
  int? price;
  int? quantity;
  bool? isExist;
  String? name;
  String? img;
  String? time;
  String? category;
  ProductModal? product;

  CartModle({this.category,this.id, this.img, this.name, this.price,this.isExist,this.quantity,this.time,this.product});

  CartModle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    time = json['time'];
    category = json['category'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    product=ProductModal.fromJson(json['product']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    data['time'] = this.time;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['isExist'] = this.isExist;
    data['product'] = this.product?.toJson();
    return data;
  }
}
