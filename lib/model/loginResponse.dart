// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.otp,
    this.mobile,
  });

  bool success;
  String message;
  String mobile;
  int otp;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message "] == null ? null : json["message "],
        mobile: json["mobile "] == null ? null : json["mobile "],
        otp: json["otp"] == null ? null : json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message ": message == null ? null : message,
        "otp": otp == null ? null : otp,
        "mobile": mobile == null ? null : mobile,
      };
}
