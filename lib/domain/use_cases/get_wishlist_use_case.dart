import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_page_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWishlistUseCase {
  final HomeRepository repository;

  GetWishlistUseCase({
    required this.repository,
  });

  Future<Either<Failures, List<ProductEntity>>> invoke() {
    return repository.getWishlist();
  }
}