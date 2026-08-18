import 'package:flutter_e_commerce_c11_online/domain/entities/product_page_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class ProductsBySubCategoryState {}

class ProductsBySubCategoryInitial
    extends ProductsBySubCategoryState {}

class ProductsBySubCategoryLoading
    extends ProductsBySubCategoryState {}

class ProductsBySubCategorySuccess
    extends ProductsBySubCategoryState {
  final ProductPageEntity products;

  ProductsBySubCategorySuccess(this.products);
}

class ProductsBySubCategoryError
    extends ProductsBySubCategoryState {
  final Failures failure;

  ProductsBySubCategoryError(this.failure);
}