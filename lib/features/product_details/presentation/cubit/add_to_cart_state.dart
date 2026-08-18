import '../../../../domain/failures.dart';

abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final String message;

  AddToCartSuccess(this.message);
}

class AddToCartError extends AddToCartState {
  final Failures failure;

  AddToCartError(this.failure);
}