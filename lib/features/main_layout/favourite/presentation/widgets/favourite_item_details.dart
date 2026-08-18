import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../domain/entities/produect_entity.dart';
import 'custom_txt_widget.dart';

class FavouriteItemDetails extends StatelessWidget {
  const FavouriteItemDetails({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextWgt(
          data: product.title,
          textStyle: getSemiBoldStyle(
            color: ColorManager.primaryDark,
            fontSize: AppSize.s18.sp,
          ),
        ),

        CustomTextWgt(
          data: product.description,
          maxLines: 2,
          textStyle: getMediumStyle(
            color: ColorManager.primaryDark,
            fontSize: AppSize.s14.sp,
          ),
        ),

        Row(
          children: [
            CustomTextWgt(
              data: "EGP ${product.price}",
              textStyle: getSemiBoldStyle(
                color: ColorManager.primaryDark,
                fontSize: AppSize.s18.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}