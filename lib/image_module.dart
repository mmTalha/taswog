import 'package:flutter/material.dart';






class image {
  List<Data> data;

  image({this.data});

  image.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int productId;
  String productName;
  String productImage;
  String units;
  String price;
  String description;
  String product;

  Data(
      {this.productId,
        this.productName,
        this.productImage,
        this.units,
        this.price,
        this.description,
        this.product});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    units = json['units'];
    price = json['Price'];
    description = json['description'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['units'] = this.units;
    data['Price'] = this.price;
    data['description'] = this.description;
    data['product'] = this.product;
    return data;
  }
}