// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  CartResponse({
    this.userId,
    this.productId,
    this.price,
    this.quantity,
    this.success,
    this.message,
    this.image,
  });

  String userId;
  String productId;
  String price;
  String quantity;
  bool success;
  String message;
  String image;

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        userId: json["user_id"] == null ? null : json["user_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        success: json["success"] == null ? null : json["success"],
        message: json["message "] == null ? null : json["message "],
        image: json["image "] == null ? null : json["image "],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "product_id": productId == null ? null : productId,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
        "success": success == null ? null : success,
        "message ": message == null ? null : message,
        "image ": message == null ? null : message,
      };
}
