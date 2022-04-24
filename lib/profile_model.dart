import 'package:flutter/foundation.dart';

class Photo {
  final int product_id;
  final String product_name;
  final String product_image;
  final String units;
  final String Price;
  final String description;
  final String product;

  Photo({
    @required this.product_id,
    @required this.product_name,
    @required this.product_image,
    @required this.units,
    @required this.Price,
    @required this.description,
    @required this.product,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {

    return Photo(
      product_name: json['product_name'] as String,
      product_id: json['product_id'] as int,
      product_image: json['product_image'] as String,
      units: json['units'] as String,
      Price: json['Price'] as String,
      description: json['description'] as String,
      product: json['product'] as String,
    );
  }
}
