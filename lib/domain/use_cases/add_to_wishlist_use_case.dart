import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToWishlistUseCase {
  final HomeRepository repository;

  AddToWishlistUseCase({
    required this.repository,
  });

  Future<Either<Failures, String>> invoke({
    required String productId,
  }) {
    return repository.addToWishlist(
      productId: productId,
    );
  }
}