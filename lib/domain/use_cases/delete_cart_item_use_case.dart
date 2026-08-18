import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCartItemUseCase {
  final HomeRepository repository;

  DeleteCartItemUseCase({
    required this.repository,
  });

  Future<Either<Failures, String>> invoke({
    required String cartItemId,
  }) {
    return repository.deleteCartItem(
      cartItemId: cartItemId,
    );
  }
}