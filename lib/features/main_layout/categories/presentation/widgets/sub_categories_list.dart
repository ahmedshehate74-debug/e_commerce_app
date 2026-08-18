import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/resources/assets_manager.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/categories/cubit/sub_categories_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/categories/cubit/sub_categories_state.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  final String? categoryId;

  const SubCategoriesList({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryId == null) {
      return const Expanded(
        flex: 2,
        child: Center(
          child: Text("Select Category"),
        ),
      );
    }

    return Expanded(
      flex: 2,
      child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
        builder: (context, state) {
          if (state is SubCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SubCategoriesError) {
            return Center(
              child: Text(
                state.failures.errorMessage,
              ),
            );
          }

          if (state is SubCategoriesSuccess) {
            final subCategories = state.subCategories;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "Sub Categories",
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = subCategories[index];

                      return SubCategoryItem(
  item.name,
    ImageAssets.subcategoryCardImage,
  () {
    Navigator.pushNamed(
      context,
      Routes.productsScreenRoute,
      arguments: item.id,
    );
  },
);
                    },
                    childCount: subCategories.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: AppSize.s8,
                    crossAxisSpacing: AppSize.s8,
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
