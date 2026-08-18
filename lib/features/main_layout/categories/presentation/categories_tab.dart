import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/categories/cubit/sub_categories_cubit.dart';
import '../../../../core/resources/values_manager.dart';

import 'widgets/categories_list.dart';
import 'widgets/sub_categories_list.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p12,
      ),
      child: Row(
        children: [
          CategoriesList(
            onCategorySelected: (id) {
              setState(() {
                selectedCategoryId = id;
              });

              context.read<SubCategoriesCubit>().getSubCategories(
                    categoryId: id,
                  );
            },
          ),

          const SizedBox(width: AppSize.s16),

          SubCategoriesList(
            categoryId: selectedCategoryId,
          ),
        ],
      ),
    );
  }
}