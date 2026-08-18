import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class TotalPriceCard extends StatelessWidget {
  final double totalPrice;

  const TotalPriceCard({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: .15),
        ),
      ),
      child: Row(
        children: [
          Text(
            "Total",
            style: getMediumStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            "EGP ${totalPrice.toStringAsFixed(0)}",
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}