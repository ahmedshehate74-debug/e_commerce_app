import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/brand_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/brand_state.dart';


import 'widgets/custom_category_widget.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands"),
        centerTitle: true,
      ),
      body: BlocBuilder<BrandCubit, BrandState>(
        builder: (context, state) {

          if (state is BrandLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BrandError) {
            return Center(
              child: Text(state.failures.errorMessage),
            );
          }

          if (state is BrandSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.brands.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .85,
              ),
              itemBuilder: (_, index) {
                final brand = state.brands[index];

                return CustomCategoryWidget(
                  title: brand.name,
                  image: brand.image,
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