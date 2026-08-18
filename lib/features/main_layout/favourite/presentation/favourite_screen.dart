import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/favourite/presentation/widgets/favourite_item.dart';
import 'package:flutter_e_commerce_c11_online/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/wishlist/cubit/wishlist_state.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() =>
      _FavouriteScreenState();
}

class _FavouriteScreenState
    extends State<FavouriteScreen> {

  @override
  void initState() {
    super.initState();

    context.read<WishlistCubit>().getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {

        if (state is WishlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is WishlistError) {
          return Center(
            child: Text(state.failure.errorMessage),
          );
        }

        if (state is WishlistSuccess) {
           print("UI Count = ${state.products.length}");
          if (state.products.isEmpty) {
            return const Center(
              child: Text("Wishlist is Empty"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.products.length,
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FavoriteItem(
                  product: state.products[index],
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}