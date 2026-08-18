import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/sub_category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';



@injectable
class GetSubCategoriesUseCase {
  final HomeRepository repository;

  GetSubCategoriesUseCase(this.repository);

  Future<Either<Failures, List<SubCategoryEntity>>> invoke({
    required String categoryId,
  }) {
    return repository.getSubCategories(
      categoryId: categoryId,
    );
}
}