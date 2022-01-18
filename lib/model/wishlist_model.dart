// To parse this JSON data, do
//
//     final wishlistResponse = wishlistResponseFromJson(jsonString);

import 'dart:convert';

WishlistResponse wishlistResponseFromJson(String str) => WishlistResponse.fromJson(json.decode(str));

String wishlistResponseToJson(WishlistResponse data) => json.encode(data.toJson());

class WishlistResponse {
  WishlistResponse({
    this.data,
    this.responce,
  });

  List<Datum> data;
  bool responce;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) => WishlistResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    responce: json["responce"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "responce": responce,
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.productId,
    this.name,
    this.price,
    this.image,
    this.quantity,
    this.status,
  });

  String id;
  String userId;
  String productId;
  String name;
  String price;
  String image;
  String quantity;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    quantity: json["quantity"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "name": name,
    "price": price,
    "image": image,
    "quantity": quantity,
    "status": status,
  };
}
