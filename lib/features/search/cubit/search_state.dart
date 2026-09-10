import '../../../../domain/entities/produect_entity.dart';
import '../model/filter_criteria.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductEntity> allProducts;
  final List<ProductEntity> filteredProducts;
  final List<String> availableCategories;
  final List<String> availableBrands;
  final double highestPrice;
  final FilterCriteria criteria;

  SearchLoaded({
    required this.allProducts,
    required this.filteredProducts,
    required this.availableCategories,
    required this.availableBrands,
    required this.highestPrice,
    required this.criteria,
  });

  bool get isEmpty => filteredProducts.isEmpty;
}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);
}