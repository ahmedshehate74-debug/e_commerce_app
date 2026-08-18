import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/brand_entity.dart';
import '../failures.dart';
import '../repository/home_repoistory.dart';
@injectable
class GetAllBrandsUseCase {
  final HomeRepository repository;

  GetAllBrandsUseCase(this.repository);

  Future<Either<Failures, List<BrandEntity>>> call() {
    return repository.getAllBrands();
  }
}