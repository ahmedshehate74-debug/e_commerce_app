import '../../../../domain/entities/produect_entity.dart';
import '../../../../domain/failures.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductEntity> products;

  final bool hasMore;

  final bool isLoadingMore;

  ProductSuccess({
    required this.products,
    required this.hasMore,
    required this.isLoadingMore,
  });
}

class ProductError extends ProductState {
  final Failures failures;

  ProductError(this.failures);
}