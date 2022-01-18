// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) => AddOrderResponse.fromJson(json.decode(str));

String addOrderResponseToJson(AddOrderResponse data) => json.encode(data.toJson());

class AddOrderResponse {
  AddOrderResponse({
    this.product,
  });

  List<Product> product;

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) => AddOrderResponse(
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.userId,
    this.proId,
    this.name,
    this.proPrice,
    this.proQty,
    this.proImage,
    this.paymentId,
    this.paymentType,
    this.address,
    this.status,
  });

  String userId;
  String proId;
  String name;
  String proPrice;
  String proQty;
  String proImage;
  String paymentId;
  String paymentType;
  String address;
  String status;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    userId: json["user_id"],
    proId: json["pro_id"],
    name: json["name"],
    proPrice: json["pro_price"],
    proQty: json["pro_qty"],
    proImage: json["pro_image"],
    paymentId: json["payment_id"],
    paymentType: json["payment_type"],
    address: json["address"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pro_id": proId,
    "name": name,
    "pro_price": proPrice,
    "pro_qty": proQty,
    "pro_image": proImage,
    "payment_id": paymentId,
    "payment_type": paymentType,
    "address": address,
    "status": status,
  };
}
