
import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<ProductEntity> products;

  WishlistSuccess(this.products);
}

class WishlistError extends WishlistState {
  final Failures failure;

  WishlistError(this.failure);
}