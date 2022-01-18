// To parse this JSON data, do
//
//     final walletResponse = walletResponseFromJson(jsonString);

import 'dart:convert';

WalletResponse walletResponseFromJson(String str) => WalletResponse.fromJson(json.decode(str));

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse {
  WalletResponse({
    this.data,
    this.responce,
  });

  List<Datum> data;
  bool responce;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
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
    this.name,
    this.email,
    this.mobile,
    this.otp,
    this.image,
    this.status,
    this.address,
    this.type,
    this.amount,
  });

  String id;
  dynamic name;
  dynamic email;
  String mobile;
  String otp;
  dynamic image;
  String status;
  dynamic address;
  String type;
  String amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    otp: json["otp"],
    image: json["image"],
    status: json["status"],
    address: json["address"],
    type: json["type"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "otp": otp,
    "image": image,
    "status": status,
    "address": address,
    "type": type,
    "amount": amount,
  };
}
