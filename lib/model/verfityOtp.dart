// To parse this JSON data, do
//
//     final verfiyOtp = verfiyOtpFromJson(jsonString);

import 'dart:convert';

VerfiyOtp verfiyOtpFromJson(String str) => VerfiyOtp.fromJson(json.decode(str));

String verfiyOtpToJson(VerfiyOtp data) => json.encode(data.toJson());

class VerfiyOtp {
  VerfiyOtp({
    this.response,
    this.status,
    this.data,
  });

  bool response;
  String status;
  Data data;

  factory VerfiyOtp.fromJson(Map<String, dynamic> json) => VerfiyOtp(
        response: json["response"] == null ? null : json["response"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response,
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.otp,
    this.address,
    this.image,
    this.status,
    this.type,
    this.amount,
  });

  String id;
  String name;
  String mobile;
  String email;
  String otp;
  String address;
  String image;
  String status;
  String type;
  String amount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        email: json["email"] == null ? null : json["email"],
        otp: json["otp"] == null ? null : json["otp"],
        address: json["address"] == null ? null : json["address"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "mobile": mobile == null ? null : mobile,
        "email": email == null ? null : email,
        "otp": otp == null ? null : otp,
        "address": address == null ? null : address,
        "image": image == null ? null : image,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "amount": amount == null ? null : type,
      };
}
