import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/product_card.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/brand_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/brand_state.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/cubit/categories_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/cubit/categories_state.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/widgets/custom_brand_widget.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/presentation/brands_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/presentation/categories_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter_e_commerce_c11_online/features/products_screen/presentation/screens/products_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/wishlist/cubit/wishlist_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/assets_manager.dart';
import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/products_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/product_state.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  late final ScrollController _productsController;
  @override
  void initState() {
    super.initState();

    _startImageSwitching();

    _productsController = ScrollController();

    _productsController.addListener(() {
      if (_productsController.position.pixels >=
          _productsController.position.maxScrollExtent - 150) {
        context.read<ProductsCubit>().loadMoreProducts();
      }
    });
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _productsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistCubit, WishlistState>(
  listener: (context, state) {
    context.read<ProductsCubit>().refreshFavouriteIds();
  },
  child: SingleChildScrollView(
      child: Column(
        children: [
          CustomAdsWidget(
            adsImages: adsImages,
            currentIndex: _currentIndex,
            timer: _timer,
          ),
          Column(
            children: [
              CustomSectionBar(
                sectionNname: 'Categories',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CategoryCubit>(),
                        child: const CategoriesScreen(),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CategorySuccess) {
                    final categories = state.categories;

                    return SizedBox(
                      height: 270.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return CustomCategoryWidget(
                            title: categories[index].name,
                            image: categories[index].image,
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
              SizedBox(height: 12.h),
              CustomSectionBar(
                  sectionNname: 'Brands',
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<BrandCubit>(),
                          child: const BrandsScreen(),
                        ),
                      ),
                    );
                  }),
              BlocBuilder<BrandCubit, BrandState>(
                builder: (context, state) {
                  if (state is BrandLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is BrandSuccess) {
                    final brands = state.brands;

                    return SizedBox(
                      height: 270.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: brands.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return CustomBrandWidget(
                            image: brands[index].image,
                            name: brands[index].name,
                          );
                        },
                      ),
                    );
                  }

                  if (state is BrandError) {
                    return Center(
                      child: Text(
                        state.failures.errorMessage,
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
              CustomSectionBar(
                sectionNname: 'Most Selling Products',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductsScreen(),
                    ),
                  );
                },
              ),
              BlocBuilder<ProductsCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const SizedBox(
                      height: 360,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is ProductError) {
                    return SizedBox(
                      height: 360,
                      child: Center(
                        child: Text(
                          state.failures.errorMessage,
                        ),
                      ),
                    );
                  }

                  if (state is ProductSuccess) {
                    return SizedBox(
                        height: 360.h,
                        child: ListView.builder(
                          controller: _productsController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              state.products.length + (state.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == state.products.length) {
                              return const SizedBox(
                                width: 120,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final product = state.products[index];

                            return ProductCard(
                              id: product.id,
                              title: product.title,
                              description: product.description,
                              rating: product.rating,
                              price: product.price,
                              priceBeforeDiscound: product.priceAfterDiscount,
                              image: product.image,
                              onWishlistTap: () async {
  final wishlistCubit = context.read<WishlistCubit>();

  if (wishlistCubit.isFavourite(product.id)) {
    await wishlistCubit.removeWishlist(
      productId: product.id,
    );
  } else {
    await wishlistCubit.addToWishlist(
      productId: product.id,
    );
  }
},
                              
                            );
                          },
                        ));
                  }

                  return const SizedBox();
                },
              ),
              SizedBox(height: 12.h),
            ],
          )
        ],
      ),
    ),

    );
  }
}
