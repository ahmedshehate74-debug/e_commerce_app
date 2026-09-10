import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../model/filter_criteria.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterCriteria initialCriteria;
  final List<String> availableCategories;
  final List<String> availableBrands;
  final double highestPrice;
  final ValueChanged<FilterCriteria> onApply;
  final VoidCallback onReset;

  const FilterBottomSheet({
    super.key,
    required this.initialCriteria,
    required this.availableCategories,
    required this.availableBrands,
    required this.highestPrice,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Set<String> _selectedCategories;
  late Set<String> _selectedBrands;
  late RangeValues _priceRange;
  late SortOption _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedCategories = Set.from(widget.initialCriteria.selectedCategories);
    _selectedBrands = Set.from(widget.initialCriteria.selectedBrands);
    _selectedSort = widget.initialCriteria.sortOption;

    final double maxP = widget.highestPrice > 0 ? widget.highestPrice : 10000;
    final double startP = widget.initialCriteria.minPrice ?? 0;
    final double endP = widget.initialCriteria.maxPrice ?? maxP;

    _priceRange = RangeValues(
      startP.clamp(0, maxP),
      endP.clamp(0, maxP),
    );
  }

  void _resetLocal() {
    final double maxP = widget.highestPrice > 0 ? widget.highestPrice : 10000;
    setState(() {
      _selectedCategories.clear();
      _selectedBrands.clear();
      _selectedSort = SortOption.none;
      _priceRange = RangeValues(0, maxP);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double maxP = widget.highestPrice > 0 ? widget.highestPrice : 10000;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filters",
                  style: getBoldStyle(
                    color: ColorManager.textColor,
                    fontSize: FontSize.s20.sp,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _resetLocal,
                      child: Text(
                        "Reset All",
                        style: getMediumStyle(
                          color: ColorManager.error,
                          fontSize: FontSize.s14.sp,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Sort By
                  _buildSectionTitle("Sort By"),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _buildSortChip("Default", SortOption.none),
                      _buildSortChip("Price: Low to High", SortOption.priceLowToHigh),
                      _buildSortChip("Price: High to Low", SortOption.priceHighToLow),
                      _buildSortChip("Top Rated", SortOption.topRated),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // 2. Price Range
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle("Price Range"),
                      Text(
                        "EGP ${_priceRange.start.toInt()} - ${_priceRange.end.toInt()}",
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s14.sp,
                        ),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: maxP,
                    divisions: maxP > 0 ? (maxP ~/ 50).clamp(10, 100) : 10,
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.containerGray,
                    labels: RangeLabels(
                      "EGP ${_priceRange.start.toInt()}",
                      "EGP ${_priceRange.end.toInt()}",
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),

                  // 3. Categories
                  if (widget.availableCategories.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    _buildSectionTitle("Category"),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: widget.availableCategories.map((cat) {
                        final isSelected = _selectedCategories.contains(cat);
                        return FilterChip(
                          label: Text(cat),
                          selected: isSelected,
                          selectedColor: ColorManager.primary.withOpacity(0.15),
                          checkmarkColor: ColorManager.primary,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? ColorManager.primary
                                : ColorManager.textColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: FontSize.s13.sp,
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? ColorManager.primary
                                : Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedCategories.add(cat);
                              } else {
                                _selectedCategories.remove(cat);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  // 4. Brands
                  if (widget.availableBrands.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    _buildSectionTitle("Brand"),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: widget.availableBrands.map((brand) {
                        final isSelected = _selectedBrands.contains(brand);
                        return FilterChip(
                          label: Text(brand),
                          selected: isSelected,
                          selectedColor: ColorManager.primary.withOpacity(0.15),
                          checkmarkColor: ColorManager.primary,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? ColorManager.primary
                                : ColorManager.textColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: FontSize.s13.sp,
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? ColorManager.primary
                                : Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedBrands.add(brand);
                              } else {
                                _selectedBrands.remove(brand);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),

          // Apply button
          Padding(
            padding: EdgeInsets.fromLTRB(AppPadding.p20.w, 8.h, AppPadding.p20.w, 24.h),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  final double maxP = widget.highestPrice > 0 ? widget.highestPrice : 10000;
                  final double? minP = _priceRange.start > 0 ? _priceRange.start : null;
                  final double? maxPriceVal = _priceRange.end < maxP ? _priceRange.end : null;

                  final newCriteria = widget.initialCriteria.copyWith(
                    selectedCategories: _selectedCategories,
                    selectedBrands: _selectedBrands,
                    minPrice: minP,
                    maxPrice: maxPriceVal,
                    sortOption: _selectedSort,
                    clearMinPrice: minP == null,
                    clearMaxPrice: maxPriceVal == null,
                  );

                  widget.onApply(newCriteria);
                  Navigator.pop(context);
                },
                child: Text(
                  "Apply Filters",
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: FontSize.s16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: getBoldStyle(
        color: ColorManager.textColor,
        fontSize: FontSize.s16.sp,
      ),
    );
  }

  Widget _buildSortChip(String label, SortOption option) {
    final isSelected = _selectedSort == option;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: ColorManager.primary.withOpacity(0.15),
      backgroundColor: Colors.grey.shade100,
      labelStyle: TextStyle(
        color: isSelected ? ColorManager.primary : ColorManager.textColor,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        fontSize: FontSize.s13.sp,
      ),
      side: BorderSide(
        color: isSelected ? ColorManager.primary : Colors.transparent,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      onSelected: (selected) {
        setState(() {
          _selectedSort = option;
        });
      },
    );
  }
}
