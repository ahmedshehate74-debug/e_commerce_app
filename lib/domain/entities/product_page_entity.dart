import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';



class ProductPageEntity {
  final List<ProductEntity> products;

  final int currentPage;

  final int numberOfPages;

  final int? nextPage;

  ProductPageEntity({
    required this.products,
    required this.currentPage,
    required this.numberOfPages,
    required this.nextPage,
  });

  bool get hasMore => nextPage != null;
}