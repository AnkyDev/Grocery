// To parse this JSON data, do
//
//     final personalcart = personalcartFromJson(jsonString);

import 'dart:convert';

Personalcart personalcartFromJson(String str) =>
    Personalcart.fromJson(json.decode(str));

String personalcartToJson(Personalcart data) => json.encode(data.toJson());

class Personalcart {
  Personalcart({
    this.data,
    this.responce,
    // this.total,
    // this.gst,
    // this.totalPriceWithGst,
  });

  List<Datum> data;
  bool responce;
  // double total;
  // double gst;
  // double totalPriceWithGst;

  factory Personalcart.fromJson(Map<String, dynamic> json) => Personalcart(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        responce: json["responce"],
        // total: json["total"],
        // gst: json["gst"],
        // totalPriceWithGst: json["total_price_with_gst"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "responce": responce,
        // "total": total,
        // "gst": gst,
        // "total_price_with_gst": totalPriceWithGst,
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.productId,
    //this.name,
    this.price,
    this.quantity,
    this.image,
  });

  String id;
  String userId;
  String productId;
  String price;
//  String name;
  String quantity;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "price": price,
        "quantity": quantity,
        "image": image,
      };
}
