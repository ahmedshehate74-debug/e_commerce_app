import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_page_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsBySubCategoryUseCase {
  final HomeRepository repository;

  GetProductsBySubCategoryUseCase(this.repository);

  Future<Either<Failures, ProductPageEntity>> call({
    required String subCategoryId,
  }) {
    return repository.getProductsBySubCategory(
      subCategoryId: subCategoryId,
    );
  }
}