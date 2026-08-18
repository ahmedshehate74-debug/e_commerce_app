import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';

class ProductDto {
  final String id;
  final String title;
  final String description;
  final String imageCover;
  final double price;
  final double? priceAfterDiscount;
  final double ratingsAverage;

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.imageCover,
    required this.price,
    this.priceAfterDiscount,
    required this.ratingsAverage,
  });

  factory ProductDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductDto(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      imageCover: json['imageCover'],
      price: (json['price'] as num).toDouble(),
      priceAfterDiscount:
          (json['priceAfterDiscount'] as num?)?.toDouble(),
      ratingsAverage:
          (json['ratingsAverage'] as num).toDouble(),
    );
  }

  /// تحويل الـ DTO إلى Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      image: imageCover,
      price: price,
      priceAfterDiscount: priceAfterDiscount ?? price,
      rating: ratingsAverage,
    );
  }
}