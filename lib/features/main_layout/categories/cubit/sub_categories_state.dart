import '../../../../domain/entities/sub_category_entity.dart';
import '../../../../domain/failures.dart';

abstract class SubCategoriesState {}

class SubCategoriesInitial extends SubCategoriesState {}

class SubCategoriesLoading extends SubCategoriesState {}

class SubCategoriesSuccess extends SubCategoriesState {
  final List<SubCategoryEntity> subCategories;

  SubCategoriesSuccess(this.subCategories);
}

class SubCategoriesError extends SubCategoriesState {
  final Failures failures;

  SubCategoriesError(this.failures);
}