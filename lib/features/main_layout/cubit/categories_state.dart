import '../../../domain/entities/category_entity.dart';
import '../../../domain/failures.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryEntity> categories;

  CategorySuccess({required this.categories});
}

class CategoryError extends CategoryState {
  final Failures error;

  CategoryError({required this.error});
}