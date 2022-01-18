// To parse this JSON data, do
//
//     final deleteAllCart = deleteAllCartFromJson(jsonString);

import 'dart:convert';

DeleteAllCart deleteAllCartFromJson(String str) => DeleteAllCart.fromJson(json.decode(str));

String deleteAllCartToJson(DeleteAllCart data) => json.encode(data.toJson());

class DeleteAllCart {
    DeleteAllCart({
        this.status,
        this.responce,
    });

    bool status;
    String responce;

    factory DeleteAllCart.fromJson(Map<String, dynamic> json) => DeleteAllCart(
        status: json["status"],
        responce: json["responce"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "responce": responce,
    };
}
