import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/routes_manager/routes.dart';
import '../../../core/widget/heart_button.dart';

import '../../wishlist/cubit/wishlist_cubit.dart';
import '../../wishlist/cubit/wishlist_state.dart';

class CustomProductWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String title;
  final String description;
  final double price;
  final double priceAfterDiscount;
  final double rating;
  final String id;

  const CustomProductWidget({
    super.key,
    required this.width,
    required this.height,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.priceAfterDiscount,
    required this.rating,
    required this.id,
  });

  String truncateTitle(String title) {
    final words = title.split(' ');
    if (words.length <= 2) return title;
    return "${words.sublist(0, 2).join(' ')}..";
  }

  String truncateDescription(String description) {
    final words = description.split(RegExp(r'[\s-]+'));
    if (words.length <= 4) return description;
    return "${words.sublist(0, 4).join(' ')}..";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: id,
        );
      },
      child: Container(
        width: width * .4,
        height: height * .3,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primary.withOpacity(.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14.r),
                    ),
                    child: Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (_, __, ___) {
                        return const Center(
                          child: Icon(Icons.image),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: BlocBuilder<WishlistCubit, WishlistState>(
                      builder: (context, state) {
                        final wishlistCubit = context.read<WishlistCubit>();

                        final isFavourite = wishlistCubit.isFavourite(id);

                        print("❤️ PRODUCT ID = $id");
                        print("❤️ IS FAVOURITE = $isFavourite");
                        print(
                            "❤️ FAVOURITE IDS = ${wishlistCubit.favouriteIds}");
                        print("❤️ STATE = ${state.runtimeType}");

                        return HeartButton(
                          isFavourite: isFavourite,
                          onTap: () async {
                            if (isFavourite) {
                              await wishlistCubit.removeWishlist(
                                productId: id,
                              );
                            } else {
                              await wishlistCubit.addToWishlist(
                                productId: id,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateTitle(title),
                      style: getMediumStyle(
                        color: ColorManager.textColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      truncateDescription(description),
                      style: getRegularStyle(
                        color: ColorManager.textColor,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EGP $price",
                          style: getRegularStyle(
                            color: ColorManager.textColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "EGP $priceAfterDiscount",
                          style: getTextWithLine(),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Review ($rating)",
                          style: getRegularStyle(
                            color: ColorManager.textColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star_rate_rounded,
                          color: ColorManager.starRateColor,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
