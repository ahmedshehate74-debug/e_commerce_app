import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

import '../entities/category_entity.dart';
import '../failures.dart';

@injectable
class GetAllCategoriesUseCase {
  final HomeRepository repository;

  GetAllCategoriesUseCase({required this.repository});

  Future<Either<Failures, List<CategoryEntity>>> call() {
    return repository.getAllCategories();
  }
}