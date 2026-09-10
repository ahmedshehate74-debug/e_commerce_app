class ProductEntity {
  final String id;
  final String title;
  final String description;
  final String image;
  final double price;
  final double priceAfterDiscount;
  final double rating;
  final String? categoryId;
  final String? categoryName;
  final String? brandId;
  final String? brandName;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.priceAfterDiscount,
    required this.rating,
    this.categoryId,
    this.categoryName,
    this.brandId,
    this.brandName,
  });
}