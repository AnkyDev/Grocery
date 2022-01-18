// To parse this JSON data, do
//
//     final personalcartdetail = personalcartdetailFromJson(jsonString);

import 'dart:convert';

Personalcartdetail personalcartdetailFromJson(String str) => Personalcartdetail.fromJson(json.decode(str));

String personalcartdetailToJson(Personalcartdetail data) => json.encode(data.toJson());

class Personalcartdetail {
  Personalcartdetail({
    this.data,
    this.responce,
    this.total,
    this.gst,
    this.totalPriceWithGst,
  });

  List<Datum> data;
  bool responce;
  int total;
  int gst;
  int totalPriceWithGst;

  factory Personalcartdetail.fromJson(Map<String, dynamic> json) => Personalcartdetail(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    responce: json["responce"],
    total: json["total"],
    gst: json["gst"],
    totalPriceWithGst: json["total_price_with_gst"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "responce": responce,
    "total": total,
    "gst": gst,
    "total_price_with_gst": totalPriceWithGst,
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.productId,
    this.name,
    this.image,
    this.price,
    this.quantity,
  });

  String id;
  String userId;
  String productId;
  String name;
  String image;
  String price;
  String quantity;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    name: json["name"],
    image: json["image"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "name": name,
    "image": image,
    "price": price,
    "quantity": quantity,
  };
}
