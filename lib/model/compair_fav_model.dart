// To parse this JSON data, do
//
//     final compairFav = compairFavFromJson(jsonString);

import 'dart:convert';

CompairFav compairFavFromJson(String str) => CompairFav.fromJson(json.decode(str));

String compairFavToJson(CompairFav data) => json.encode(data.toJson());

class CompairFav {
    CompairFav({
        this.data,
    });

    bool data;

    factory CompairFav.fromJson(Map<String, dynamic> json) => CompairFav(
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
    };
}
