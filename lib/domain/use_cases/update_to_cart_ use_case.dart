import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartCountUseCase {
  final HomeRepository repository;

  UpdateCartCountUseCase({
    required this.repository,
  });

  Future<Either<Failures,  CartEntity>> invoke({
    required String cartItemId,
    required int count,
  }) {
    return repository.updateCartCount(
      cartItemId: cartItemId,
      count: count,
    );
  }
}