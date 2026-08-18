import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartEntity cart;

  CartSuccess(this.cart);
}

class CartError extends CartState {
  final Failures failure;

  CartError(this.failure);
}