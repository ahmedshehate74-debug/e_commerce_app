import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/produect_entity.dart';
import '../../../../domain/use_cases/get_all_products_use_case.dart';
import '../model/filter_criteria.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  SearchCubit(this.getAllProductsUseCase) : super(SearchInitial());

  List<ProductEntity> _allProducts = [];
  FilterCriteria _criteria = const FilterCriteria();
  List<String> _availableCategories = [];
  List<String> _availableBrands = [];
  double _highestPrice = 10000;

  FilterCriteria get currentCriteria => _criteria;
  double get highestPrice => _highestPrice;
  List<String> get availableCategories => _availableCategories;
  List<String> get availableBrands => _availableBrands;

  Future<void> initSearch({String? initialQuery}) async {
    emit(SearchLoading());

    if (initialQuery != null) {
      _criteria = _criteria.copyWith(query: initialQuery);
    }

    if (_allProducts.isEmpty) {
      final result = await getAllProductsUseCase(
        page: 1,
        limit: 100,
      );

      result.fold(
        (failure) {
          emit(SearchError(failure.errorMessage));
        },
        (pageEntity) {
          _allProducts = pageEntity.products;
          _extractMetadata();
          _applyFilterAndEmit();
        },
      );
    } else {
      _applyFilterAndEmit();
    }
  }

  void _extractMetadata() {
    final categoriesSet = <String>{};
    final brandsSet = <String>{};
    double maxPrice = 0;

    for (final product in _allProducts) {
      if (product.categoryName != null && product.categoryName!.trim().isNotEmpty) {
        categoriesSet.add(product.categoryName!.trim());
      }
      if (product.brandName != null && product.brandName!.trim().isNotEmpty) {
        brandsSet.add(product.brandName!.trim());
      }
      if (product.price > maxPrice) {
        maxPrice = product.price;
      }
    }

    _availableCategories = categoriesSet.toList()..sort();
    _availableBrands = brandsSet.toList()..sort();
    _highestPrice = maxPrice > 0 ? maxPrice : 10000;
  }

  void onQueryChanged(String query) {
    _criteria = _criteria.copyWith(query: query);
    _applyFilterAndEmit();
  }

  void applyFilters(FilterCriteria newCriteria) {
    _criteria = newCriteria;
    _applyFilterAndEmit();
  }

  void resetFilters() {
    _criteria = _criteria.clearFilters();
    _applyFilterAndEmit();
  }

  void clearQuery() {
    _criteria = _criteria.copyWith(query: '');
    _applyFilterAndEmit();
  }

  void _applyFilterAndEmit() {
    final q = _criteria.query.trim().toLowerCase();

    List<ProductEntity> filtered = _allProducts.where((product) {
      // 1. Query search on title, description, category, and brand
      if (q.isNotEmpty) {
        final matchesTitle = product.title.toLowerCase().contains(q);
        final matchesDesc = product.description.toLowerCase().contains(q);
        final matchesCat =
            product.categoryName?.toLowerCase().contains(q) ?? false;
        final matchesBrand =
            product.brandName?.toLowerCase().contains(q) ?? false;

        if (!matchesTitle && !matchesDesc && !matchesCat && !matchesBrand) {
          return false;
        }
      }

      // 2. Category filter
      if (_criteria.selectedCategories.isNotEmpty) {
        if (product.categoryName == null ||
            !_criteria.selectedCategories.contains(product.categoryName)) {
          return false;
        }
      }

      // 3. Brand filter
      if (_criteria.selectedBrands.isNotEmpty) {
        if (product.brandName == null ||
            !_criteria.selectedBrands.contains(product.brandName)) {
          return false;
        }
      }

      // 4. Min Price filter
      if (_criteria.minPrice != null && product.price < _criteria.minPrice!) {
        return false;
      }

      // 5. Max Price filter
      if (_criteria.maxPrice != null && product.price > _criteria.maxPrice!) {
        return false;
      }

      return true;
    }).toList();

    // 6. Sorting
    switch (_criteria.sortOption) {
      case SortOption.priceLowToHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.topRated:
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.none:
        break;
    }

    emit(SearchLoaded(
      allProducts: _allProducts,
      filteredProducts: filtered,
      availableCategories: _availableCategories,
      availableBrands: _availableBrands,
      highestPrice: _highestPrice,
      criteria: _criteria,
    ));
  }
}