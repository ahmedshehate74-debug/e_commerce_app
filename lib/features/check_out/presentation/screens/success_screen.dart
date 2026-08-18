import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55.r,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: 70.sp,
                  ),
                ),

                SizedBox(height: 30.h),

                Text(
                  "Payment Successful",
                  style: getBoldStyle(
                    color: ColorManager.textColor,
                    fontSize: 24,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "Your payment has been completed successfully.",
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 35.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      _buildItem("Order Number", "#258963"),
                      Divider(height: 25.h),
                      _buildItem("Payment Method", "Visa"),
                      Divider(height: 25.h),
                      _buildItem("Status", "Paid"),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18.r),
                      ),
                    ),
                    onPressed: () {
                     Navigator.pushNamedAndRemoveUntil(
  context,
  Routes.mainRoute,
  (route) => false,
);
                    },
                    child: Text(
                      "Continue Shopping",
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: getMediumStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: getBoldStyle(
            color: ColorManager.textColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}