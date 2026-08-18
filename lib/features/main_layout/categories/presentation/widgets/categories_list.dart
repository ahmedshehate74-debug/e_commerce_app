import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/cubit/categories_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/cubit/categories_state.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import 'category_item.dart';

class CategoriesList extends StatefulWidget {
  final Function(String categoryId) onCategorySelected;

  const CategoriesList({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<CategoriesList> createState() =>
      _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // Index of the currently selected category
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        color: ColorManager.containerGray,
        border: Border(
            // set the border for only 3 sides
            top: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3)),
            left: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3)),
            bottom: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3))),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
      ),

      // the categories items list
      child: ClipRRect(
        // clip the corners of the container that hold the list view
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
        child:  BlocBuilder<CategoryCubit, CategoryState>(
  builder: (context, state) {

    if (state is CategoryLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is CategorySuccess) {

      final categories = state.categories;

      return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {

          final category = categories[index];

          return CategoryItem(
            index,
            category.name,
            selectedIndex == index,
            (i) {

              setState(() {
                selectedIndex = i;
              });

              widget.onCategorySelected(
                category.id,
              );
            },
          );
        },
      );
    }

    return const SizedBox();
  },
),
      ),
    ));
  }

  // callback function to change the selected index
  onItemClick(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
