import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';

import '../../domain/entities/product_page_entity.dart';

class WishlistDto {
  final List<WishlistProductDto> products;

  WishlistDto({
    required this.products,
  });

  factory WishlistDto.fromJson(Map<String, dynamic> json) {
    return WishlistDto(
      products: (json["data"] as List)
          .map((e) => WishlistProductDto.fromJson(e))
          .toList(),
    );
  }

  List<ProductEntity> toEntity() {
    return products.map((e) => e.toEntity()).toList();
  }
}

class WishlistProductDto {
  final String id;
  final String title;
  final String image;
  final double price;
  final double rating;

  WishlistProductDto({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory WishlistProductDto.fromJson(Map<String, dynamic> json) {
    return WishlistProductDto(
      id: json["_id"],
      title: json["title"],
      image: json["imageCover"],
      price: (json["price"] as num).toDouble(),
      rating: (json["ratingsAverage"] as num).toDouble(),
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      image: image,
      price: price,
      rating: rating,
      description: "",
      priceAfterDiscount: 0,
     
    );
  }
}