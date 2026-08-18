import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/categories_cubit.dart';
import '../../cubit/categories_state.dart';
import 'widgets/custom_category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {

          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoryError) {
            return Center(
              child: Text(state.error.errorMessage),
            );
          }

          if (state is CategorySuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .85,
              ),
              itemBuilder: (_, index) {
                final category = state.categories[index];

                return CustomCategoryWidget(
                  title: category.name,
                  image: category.image,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}