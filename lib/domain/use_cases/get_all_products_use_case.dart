import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

import '../entities/product_page_entity.dart';
import '../failures.dart';

@injectable
class GetAllProductsUseCase {
  final HomeRepository repository;

  GetAllProductsUseCase(this.repository);

  Future<Either<Failures, ProductPageEntity>> call({
    required int page,
    String? subCategoryId,
    String? keyword,
  }) {
    return repository.getAllProducts(
      page: page,
      subCategoryId: subCategoryId,
      keyword: keyword,
    );
  }
}