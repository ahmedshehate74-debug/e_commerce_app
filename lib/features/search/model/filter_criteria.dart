enum SortOption {
  none,
  priceLowToHigh,
  priceHighToLow,
  topRated,
}

class FilterCriteria {
  final String query;
  final Set<String> selectedCategories;
  final Set<String> selectedBrands;
  final double? minPrice;
  final double? maxPrice;
  final SortOption sortOption;

  const FilterCriteria({
    this.query = '',
    this.selectedCategories = const {},
    this.selectedBrands = const {},
    this.minPrice,
    this.maxPrice,
    this.sortOption = SortOption.none,
  });

  bool get hasActiveFilters =>
      selectedCategories.isNotEmpty ||
      selectedBrands.isNotEmpty ||
      minPrice != null ||
      maxPrice != null ||
      sortOption != SortOption.none;

  int get activeFiltersCount {
    int count = 0;
    count += selectedCategories.length;
    count += selectedBrands.length;
    if (minPrice != null || maxPrice != null) count++;
    if (sortOption != SortOption.none) count++;
    return count;
  }

  FilterCriteria copyWith({
    String? query,
    Set<String>? selectedCategories,
    Set<String>? selectedBrands,
    double? minPrice,
    double? maxPrice,
    SortOption? sortOption,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
  }) {
    return FilterCriteria(
      query: query ?? this.query,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  FilterCriteria clearFilters() {
    return FilterCriteria(query: query);
  }
}
