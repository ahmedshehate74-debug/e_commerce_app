import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_details_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductDetailsUseCase {
  final HomeRepository repository;

  GetProductDetailsUseCase({
    required this.repository,
  });

  Future<Either<Failures, ProductDetailsEntity>> invoke({
    required String id,
  }) {
    return repository.getProductDetails(
      id: id,
    );
  }
}