import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../model/payment_method_model.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethodModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodItem({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.02 : 1,
      duration: const Duration(milliseconds: 250),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isSelected
                  ? ColorManager.primary
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 64.w,
                height: 46.h,
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Image.asset(
                  model.image,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(width: 18.w),

              Expanded(
                child: Text(
                  model.title,
                  style: getSemiBoldStyle(
                    color: ColorManager.textColor,
                    fontSize: 17,
                  ),
                ),
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 26.w,
                height: 26.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? ColorManager.primary
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.primary
                        : Colors.grey.shade400,
                    width: 1.8,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}