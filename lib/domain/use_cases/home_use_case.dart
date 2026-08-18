import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/brand_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeUseCase {
  HomeRepository repository;
  HomeUseCase({required this.repository});

 Future<Either<Failures, List<CategoryEntity>>> getCategories() {
    return repository.getAllCategories();
  }
  Future<Either<Failures, List<BrandEntity>>> getBrands() {
    return repository.getAllBrands();
  }
   
}