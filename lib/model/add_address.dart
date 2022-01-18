// To parse this JSON data, do
//
//     final addAddress = addAddressFromJson(jsonString);

import 'dart:convert';

AddAddress addAddressFromJson(String str) => AddAddress.fromJson(json.decode(str));

String addAddressToJson(AddAddress data) => json.encode(data.toJson());

class AddAddress {
  AddAddress({
    this.data,
    this.responce,
  });

  List<Datum> data;
  bool responce;

  factory AddAddress.fromJson(Map<String, dynamic> json) => AddAddress(
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
    this.name,
    this.phone,
    this.pinCode,
    this.state,
    this.city,
    this.houseNo,
    this.roadNo,
  });

  String id;
  String userId;
  String name;
  String phone;
  String pinCode;
  String state;
  String city;
  String houseNo;
  String roadNo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    phone: json["phone"],
    pinCode: json["pin_code"],
    state: json["state"],
    city: json["city"],
    houseNo: json["house_no"],
    roadNo: json["road_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "phone": phone,
    "pin_code": pinCode,
    "state": state,
    "city": city,
    "house_no": houseNo,
    "road_no": roadNo,
  };
}
