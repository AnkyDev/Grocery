// To parse this JSON data, do
//
//     final placeOrderResponce = placeOrderResponceFromJson(jsonString);

import 'dart:convert';

PlaceOrderResponce placeOrderResponceFromJson(String str) => PlaceOrderResponce.fromJson(json.decode(str));

String placeOrderResponceToJson(PlaceOrderResponce data) => json.encode(data.toJson());

class PlaceOrderResponce {
    PlaceOrderResponce({
        this.data,
        this.responce,
    });

    List<Datum> data;
    bool responce;

    factory PlaceOrderResponce.fromJson(Map<String, dynamic> json) => PlaceOrderResponce(
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
        this.paymentType,
        this.paymentId,
        this.address,
        this.orderStatus,
        this.productName,
    });

    String id;
    String userId;
    String productId;
    dynamic name;
    String price;
    String image;
    String quantity;
    String paymentType;
    String paymentId;
    String address;
    String orderStatus;
    String productName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        quantity: json["quantity"],
        paymentType: json["payment_type"],
        paymentId: json["payment_id"],
        address: json["address"],
        orderStatus: json["order_status"],
        productName: json["product_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "name": name,
        "price": price,
        "image": image,
        "quantity": quantity,
        "payment_type": paymentType,
        "payment_id": paymentId,
        "address": address,
        "order_status": orderStatus,
        "product_name": productName,
    };
}
