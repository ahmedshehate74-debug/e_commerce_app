import '../../domain/entities/product_details_entity.dart';

class ProductDetailsDto {
  final String id;

  final String title;

  final String description;

  final String imageCover;

  final List<String> images;

  final double price;

  final double rating;

  final double? priceAfterDiscount;

  final int quantity;

  final int sold;

  final int ratingsQuantity;

  final String brandName;

  final String categoryName;

  ProductDetailsDto({
    required this.id,
    required this.title,
    required this.description,
    required this.imageCover,
    required this.images,
    required this.price,
    required this.rating,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.sold,
    required this.ratingsQuantity,
    required this.brandName,
    required this.categoryName,
  });
  factory ProductDetailsDto.fromJson(
    Map<String, dynamic> json,
) {
  return ProductDetailsDto(
    id: json["_id"],

    title: json["title"],

    description: json["description"],

    imageCover: json["imageCover"],

    images: List<String>.from(json["images"]),

    price: (json["price"] as num).toDouble(),

    rating: (json["ratingsAverage"] as num).toDouble(),

    priceAfterDiscount:
        (json["priceAfterDiscount"] as num?)?.toDouble(),

    quantity: json["quantity"],

    sold: json["sold"],

    ratingsQuantity: json["ratingsQuantity"],

    brandName: json["brand"]["name"],

    categoryName: json["category"]["name"],
  );
}
ProductDetailsEntity toEntity() {
  return ProductDetailsEntity(
    id: id,

    title: title,

    description: description,

    imageCover: imageCover,

    images: images,

    price: price,

    rating: rating,

    priceAfterDiscount: priceAfterDiscount,

    quantity: quantity,

    sold: sold,

    ratingsQuantity: ratingsQuantity,

    brandName: brandName,

    categoryName: categoryName,
  );
}
}