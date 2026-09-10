import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/product_card.dart';
import 'package:flutter_e_commerce_c11_online/features/search/cubit/search_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/search/cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SearchError) {
            return Center(
              child: Text(state.failure.errorMessage ?? "Something went wrong"),
            );
          }

          if (state is SearchSuccess) {
            final products = state.productPage.products;

            if (products.isEmpty) {
              return const Center(
                child: Text("No products found"),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  id: product.id,
                  image: product.image,
                  title: product.title,
                  price: product.priceAfterDiscount,
                  priceBeforeDiscound: product.price,
                  description: product.description,
                  rating: product.rating,
                );
              },
            );
          }

          return const Center(
            child: Text("Search for products"),
          );
        },
      ),
    );
  }
}