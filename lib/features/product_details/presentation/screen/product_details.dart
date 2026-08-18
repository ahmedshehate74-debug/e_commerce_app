import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/features/cart/cubit/cart_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/product_details/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/product_details/presentation/cubit/add_to_cart_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../cubit/product_details_cubit.dart';
import '../../cubit/product_details_state.dart';
import '../widgets/product_color.dart';
import '../widgets/product_description.dart';
import '../widgets/product_item.dart';
import '../widgets/product_label.dart';
import '../widgets/product_rating.dart';
import '../widgets/product_size.dart';
import '../widgets/product_slider.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  const ProductDetails({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();

    context.read<ProductDetailsCubit>().getProductDetails(
          widget.productId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.blue,
            ),
          );

          CartCubit.get(context).getCart();
        }

        if (state is AddToCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is ProductDetailsError) {
            return Scaffold(
              body: Center(
                child: Text(state.failures.errorMessage),
              ),
            );
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Product Details",
                  style: getMediumStyle(
                    color: ColorManager.appBarTitleColor,
                  ).copyWith(fontSize: 20.sp),
                ),
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
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 50.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductSlider(
                        items: product.images
                            .map(
                              (image) => ProductItem(
                                imageUrl: image,
                              ),
                            )
                            .toList(),
                        initialIndex: 0,
                      ),
                      SizedBox(height: 24.h),
                      ProductLabel(
                        productName: product.title,
                        productPrice: "EGP ${product.price}",
                      ),
                      SizedBox(height: 16.h),
                      ProductRating(
                        productBuyers: product.sold.toString(),
                        productRating:
                            "${product.rating} (${product.ratingsQuantity})",
                      ),
                      SizedBox(height: 16.h),
                      ProductDescription(
                        productDescription: product.description,
                      ),
                      SizedBox(height: 20.h),
                      ProductSize(
                        size: const [35, 38, 39, 40],
                        onSelected: () {},
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Color",
                        style: getMediumStyle(
                          color: ColorManager.appBarTitleColor,
                        ).copyWith(fontSize: 18.sp),
                      ),
                      ProductColor(
                        color: const [
                          Colors.red,
                          Colors.blueAccent,
                          Colors.green,
                          Colors.yellow,
                        ],
                        onSelected: () {},
                      ),
                      SizedBox(height: 48.h),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total price",
                                style: getMediumStyle(
                                  color: ColorManager.primary.withOpacity(.6),
                                ).copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "EGP ${product.price}",
                                style: getMediumStyle(
                                  color: ColorManager.appBarTitleColor,
                                ).copyWith(fontSize: 18.sp),
                              ),
                            ],
                          ),
                          SizedBox(width: 33.w),
                          Expanded(
                            child: CustomElevatedButton(
                              label: "Add to cart",
                              onTap: () {
                                AddToCartCubit.get(context).addToCart(
                                  product.id,
                                );
                              },
                              prefixIcon: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const Scaffold(
            body: SizedBox(),
          );
        },
      ),
    );
  }
}
