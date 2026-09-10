import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../products_screen/widgets/custom_product_widget.dart';
import '../../cubit/search_cubit.dart';
import '../../cubit/search_state.dart';
import '../../model/filter_criteria.dart';
import '../widgets/filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({
    super.key,
    this.initialQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().initSearch(
            initialQuery: widget.initialQuery,
          );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 250), () {
      if (mounted) {
        context.read<SearchCubit>().onQueryChanged(value);
      }
    });
    setState(() {});
  }

  void _openFilterBottomSheet(SearchLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        initialCriteria: state.criteria,
        availableCategories: state.availableCategories,
        availableBrands: state.availableBrands,
        highestPrice: state.highestPrice,
        onApply: (newCriteria) {
          context.read<SearchCubit>().applyFilters(newCriteria);
        },
        onReset: () {
          context.read<SearchCubit>().resetFilters();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.primary,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Search Products",
          style: getBoldStyle(
            color: ColorManager.textColor,
            fontSize: FontSize.s18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar + Filter Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p16.w,
                vertical: 8.h,
              ),
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  final activeFiltersCount = state is SearchLoaded
                      ? state.criteria.activeFiltersCount
                      : 0;

                  return Row(
                    children: [
                      // Search Input Field
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          autofocus: widget.initialQuery == null,
                          cursorColor: ColorManager.primary,
                          style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s15.sp,
                          ),
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppMargin.m12.w,
                              vertical: AppMargin.m8.h,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                width: AppSize.s1,
                                color: ColorManager.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                width: AppSize.s1,
                                color: ColorManager.primary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: ColorManager.primary,
                              ),
                            ),
                            prefixIcon: ImageIcon(
                              AssetImage(IconsAssets.icSearch),
                              color: ColorManager.primary,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: ColorManager.grey,
                                      size: 18.sp,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      context.read<SearchCubit>().clearQuery();
                                      setState(() {});
                                    },
                                  )
                                : null,
                            hintText: "Search by name, brand, category...",
                            hintStyle: getRegularStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s14.sp,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      // Filter Icon Button with badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: state is SearchLoaded
                                ? () => _openFilterBottomSheet(state)
                                : null,
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: activeFiltersCount > 0
                                    ? ColorManager.primary
                                    : ColorManager.containerGray.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.tune_rounded,
                                color: activeFiltersCount > 0
                                    ? Colors.white
                                    : ColorManager.primary,
                                size: 22.sp,
                              ),
                            ),
                          ),
                          if (activeFiltersCount > 0)
                            Positioned(
                              right: -4.w,
                              top: -4.h,
                              child: Container(
                                padding: EdgeInsets.all(5.r),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "$activeFiltersCount",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            // Active Filters Chips row (if any)
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoaded && state.criteria.hasActiveFilters) {
                  return _buildActiveFilterChips(state.criteria);
                }
                return const SizedBox.shrink();
              },
            ),

            // Results count
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoaded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p16.w,
                      vertical: 4.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Results (${state.filteredProducts.length})",
                          style: getMediumStyle(
                            color: ColorManager.textColor,
                            fontSize: FontSize.s13.sp,
                          ),
                        ),
                        if (state.criteria.hasActiveFilters)
                          GestureDetector(
                            onTap: () {
                              context.read<SearchCubit>().resetFilters();
                            },
                            child: Text(
                              "Clear filters",
                              style: getRegularStyle(
                                color: ColorManager.error,
                                fontSize: FontSize.s12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Content Grid / Loading / Empty State
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: ColorManager.error,
                            size: 48.sp,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            state.errorMessage,
                            style: getMediumStyle(
                              color: ColorManager.textColor,
                              fontSize: FontSize.s14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                            ),
                            onPressed: () {
                              context.read<SearchCubit>().initSearch(
                                    initialQuery: _searchController.text,
                                  );
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchLoaded) {
                    if (state.isEmpty) {
                      return _buildEmptyState(state.criteria.hasActiveFilters);
                    }

                    return GridView.builder(
                      padding: EdgeInsets.all(AppPadding.p16.r),
                      itemCount: state.filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.62,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.filteredProducts[index];
                        return CustomProductWidget(
                          width: width,
                          height: height,
                          image: product.image,
                          title: product.title,
                          description: product.description,
                          price: product.price,
                          priceAfterDiscount: product.priceAfterDiscount,
                          rating: product.rating,
                          id: product.id,
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilterChips(FilterCriteria criteria) {
    return Container(
      height: 36.h,
      margin: EdgeInsets.only(bottom: 6.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        children: [
          // Categories
          ...criteria.selectedCategories.map(
            (cat) => _buildRemovableChip(
              label: cat,
              onDelete: () {
                final updated = Set<String>.from(criteria.selectedCategories)
                  ..remove(cat);
                context
                    .read<SearchCubit>()
                    .applyFilters(criteria.copyWith(selectedCategories: updated));
              },
            ),
          ),
          // Brands
          ...criteria.selectedBrands.map(
            (brand) => _buildRemovableChip(
              label: brand,
              onDelete: () {
                final updated = Set<String>.from(criteria.selectedBrands)
                  ..remove(brand);
                context
                    .read<SearchCubit>()
                    .applyFilters(criteria.copyWith(selectedBrands: updated));
              },
            ),
          ),
          // Price Range
          if (criteria.minPrice != null || criteria.maxPrice != null)
            _buildRemovableChip(
              label:
                  "Price: ${criteria.minPrice?.toInt() ?? 0} - ${criteria.maxPrice?.toInt() ?? ''}",
              onDelete: () {
                context.read<SearchCubit>().applyFilters(
                      criteria.copyWith(
                        clearMinPrice: true,
                        clearMaxPrice: true,
                      ),
                    );
              },
            ),
          // Sort
          if (criteria.sortOption != SortOption.none)
            _buildRemovableChip(
              label: _getSortLabel(criteria.sortOption),
              onDelete: () {
                context.read<SearchCubit>().applyFilters(
                      criteria.copyWith(sortOption: SortOption.none),
                    );
              },
            ),
        ],
      ),
    );
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.priceLowToHigh:
        return "Price: Low to High";
      case SortOption.priceHighToLow:
        return "Price: High to Low";
      case SortOption.topRated:
        return "Top Rated";
      case SortOption.none:
        return "";
    }
  }

  Widget _buildRemovableChip({
    required String label,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 6.w),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: ColorManager.primary,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: ColorManager.primary.withOpacity(0.08),
        deleteIcon: Icon(
          Icons.close,
          size: 14.sp,
          color: ColorManager.primary,
        ),
        onDeleted: onDelete,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: ColorManager.primary.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool hasFilters) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: ColorManager.containerGray.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 64.sp,
                color: ColorManager.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "No products found",
              style: getBoldStyle(
                color: ColorManager.textColor,
                fontSize: FontSize.s18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              hasFilters
                  ? "We couldn't find any products matching your search or filters. Try adjusting or clearing your filters."
                  : "We couldn't find any products matching your search. Try checking for typos or using different keywords.",
              style: getRegularStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s13.sp,
              ),
              textAlign: TextAlign.center,
            ),
            if (hasFilters) ...[
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  context.read<SearchCubit>().resetFilters();
                },
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  "Reset All Filters",
                  style: getMediumStyle(
                    color: Colors.white,
                    fontSize: FontSize.s14.sp,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
