// To parse this JSON data, do
//
//     final userOrder = userOrderFromJson(jsonString);

import 'dart:convert';

UserOrder userOrderFromJson(String str) => UserOrder.fromJson(json.decode(str));

String userOrderToJson(UserOrder data) => json.encode(data.toJson());

class UserOrder {
  UserOrder({
    this.status,
    this.message,
    this.orderId,
    this.data,
    this.responce,
  });

  int status;
  String message;
  String orderId;
  List<Datum> data;
  bool responce;

  factory UserOrder.fromJson(Map<String, dynamic> json) => UserOrder(
        status: json["status"],
        message: json["message"],
        orderId: json["order_id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        responce: json["responce"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_id": orderId,
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
    this.paymentType,
    this.paymentId,
    this.address,
    this.staus,
  });

  String id;
  String userId;
  String productId;
  String name;
  String price;
  String image;
  String quantity;
  String paymentType;
  String paymentId;
  String address;
  String staus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"],
        image: json["image"],
        quantity: json["quantity"],
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        paymentId: json["payment_id"] == null ? null : json["payment_id"],
        address: json["address"] == null ? null : json["address"],
        staus: json["staus"] == null ? null : json["staus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "name": name == null ? null : name,
        "price": price,
        "image": image,
        "quantity": quantity,
        "payment_type": paymentType == null ? null : paymentType,
        "payment_id": paymentId == null ? null : paymentId,
        "address": address == null ? null : address,
        "staus": staus == null ? null : staus,
      };
}
