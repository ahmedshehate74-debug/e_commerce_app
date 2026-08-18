import 'package:flutter_e_commerce_c11_online/domain/entities/product_details_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsEntity product;

  ProductDetailsSuccess(this.product);
}

class ProductDetailsError extends ProductDetailsState {
  final Failures failures;

  ProductDetailsError(this.failures);
}