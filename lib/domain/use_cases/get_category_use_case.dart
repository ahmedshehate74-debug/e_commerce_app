import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failures, List<CategoryEntity>>> call() {
     return repository.getAllCategories();
  }
}