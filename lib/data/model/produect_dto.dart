import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';

class ProductDto {
  final String id;
  final String title;
  final String description;
  final String imageCover;
  final double price;
  final double? priceAfterDiscount;
  final double ratingsAverage;
  final String? categoryId;
  final String? categoryName;
  final String? brandId;
  final String? brandName;

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.imageCover,
    required this.price,
    this.priceAfterDiscount,
    required this.ratingsAverage,
    this.categoryId,
    this.categoryName,
    this.brandId,
    this.brandName,
  });

  factory ProductDto.fromJson(
    Map<String, dynamic> json,
  ) {
    String? catId;
    String? catName;
    if (json['category'] != null) {
      if (json['category'] is Map<String, dynamic>) {
        catId = json['category']['_id']?.toString();
        catName = json['category']['name']?.toString();
      } else if (json['category'] is String) {
        catId = json['category'] as String;
      }
    }

    String? brId;
    String? brName;
    if (json['brand'] != null) {
      if (json['brand'] is Map<String, dynamic>) {
        brId = json['brand']['_id']?.toString();
        brName = json['brand']['name']?.toString();
      } else if (json['brand'] is String) {
        brId = json['brand'] as String;
      }
    }

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
      categoryId: catId,
      categoryName: catName,
      brandId: brId,
      brandName: brName,
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
      categoryId: categoryId,
      categoryName: categoryName,
      brandId: brandId,
      brandName: brandName,
    );
  }
}