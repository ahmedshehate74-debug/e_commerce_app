import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/wishlist_cubit.dart';
import '../cubit/wishlist_state.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
      ),

      body: BlocBuilder<WishlistCubit, WishlistState>(
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
            return ListView.builder(
              itemCount: state.products.length,

              itemBuilder: (context, index) {

                final product = state.products[index];

                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),

                  title: Text(product.title),

                  subtitle: Text(
                    "${product.price} EGP",
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,

                    onPressed: () {
                      WishlistCubit.get(context).removeWishlist(
                        productId: product.id,
                      );
                    },
                  ),
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