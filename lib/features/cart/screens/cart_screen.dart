import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/model/payment_args.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/resources/values_manager.dart';

import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

import '../widgets/cart_item_widget.dart';
import '../widgets/total_price_and_checkout_botton.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    CartCubit.get(context).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: getMediumStyle(
            fontSize: 20,
            color: ColorManager.textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage(IconsAssets.icSearch),
              color: ColorManager.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage(IconsAssets.icCart),
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartError) {
            return Center(
              child: Text(
                state.failure.errorMessage,
              ),
            );
          }

          if (state is CartSuccess) {
            final cart = state.cart;

            return Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cart.products.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: AppSize.s12.h),
                      itemBuilder: (context, index) {
                        final product = cart.products[index];

                        return CartItemWidget(
                          productId: product.id,
                          imagePath: product.image,
                          title: product.title,
                          price: product.price,
                          quantity: product.count,
                          color: Colors.black,
                          colorName: "Black",
                          size: 40,
                          onDeleteTap: () {
                            CartCubit.get(context).deleteCartItem(
                              product.cartItemId,
                            );
                          },
                          onIncrementTap: (value) {
                            CartCubit.get(context).updateCartCount(
                              cartItemId: product.cartItemId,
                              count: value + 1,
                            );
                          },
                          onDecrementTap: (value) {
                            if (value > 1) {
                              CartCubit.get(context).updateCartCount(
                                cartItemId: product.cartItemId,
                                count: value - 1,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  TotalPriceAndCheckoutBotton(
                    totalPrice: cart.totalCartPrice,
                    checkoutButtonOnTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.paymentMethod,
                        arguments: PaymentArgs(
                          totalPrice: cart.totalCartPrice.toDouble(),
                          cartId: cart.cartId,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
