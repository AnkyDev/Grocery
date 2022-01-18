// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.product,
  });

  List<Product> product;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        product: json["product"] == null
            ? null
            : List<Product>.from(
                json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.image,
    this.category,
    this.quantity,
  });

  String id;
  String productId;
  String name;
  String price;
  String image;
  String category;
  String quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        image: json["image"] == null ? null : json["image"],
        category: json["category"] == null ? null : json["category"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "image": image == null ? null : image,
        "category": category == null ? null : category,
        "quantity": quantity == null ? null : quantity,
      };
}
