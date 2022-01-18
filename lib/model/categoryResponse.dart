// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  CategoryResponse({
    this.category,
  });

  List<Category> category;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.catId,
    this.name,
    this.image,
  });

  String id;
  String catId;
  String name;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        catId: json["cat_id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "name": name,
        "image": image,
      };
}
