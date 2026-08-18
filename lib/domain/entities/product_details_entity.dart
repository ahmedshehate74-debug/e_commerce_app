class ProductDetailsEntity {
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
  

  ProductDetailsEntity({
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
}