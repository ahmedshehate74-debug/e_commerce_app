import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/cubit/checkout_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../cubit/checkout_cubit.dart';
import '../../model/payment_method_model.dart';
import '../widgets/payment_method_item.dart';
import '../widgets/total_price_card.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double totalPrice;
  final String cartId;

  const PaymentMethodScreen({
    super.key,
    required this.totalPrice,
    required this.cartId,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethodType selectedMethod = PaymentMethodType.visa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Payment Method",
          style: getBoldStyle(
            color: ColorManager.textColor,
            fontSize: 22,
          ),
        ),
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            success: (paymentId, paymentMethod, status) {
              // اقفل Loading Dialog
              Navigator.pop(context);

              Navigator.pushReplacementNamed(
                context,
                Routes.successScreen,
                arguments: {
                  "paymentId": paymentId,
                  "paymentMethod": paymentMethod,
                  "status": status,
                  "totalPrice": widget.totalPrice,
                },
              );
            },
            failure: (message) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),
            child: Column(
              children: [
                TotalPriceCard(
                  totalPrice: widget.totalPrice,
                ),
                SizedBox(height: 45.h),
                Row(
                  children: [
                    Icon(
                      Icons.payment_rounded,
                      color: ColorManager.primary,
                      size: 24.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Choose Payment Method",
                      style: getBoldStyle(
                        color: ColorManager.textColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: paymentMethods.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final method = paymentMethods[index];

                      return PaymentMethodItem(
                        model: method,
                        isSelected: selectedMethod == method.type,
                        onTap: () {
                          setState(() {
                            selectedMethod = method.type;
                          });
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  height: 58.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shadowColor: Colors.black26,
                      backgroundColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                    ),
                    onPressed: () {
                      switch (selectedMethod) {
                        case PaymentMethodType.visa:
                        case PaymentMethodType.masterCard:
                        case PaymentMethodType.applePay:
                          context.read<CheckoutCubit>().makePayment(
                                cartId: widget.cartId,
                                totalPrice: widget.totalPrice,
                              );
                          break;

                        case PaymentMethodType.paypal:
                          context.read<CheckoutCubit>().makePaypalPayment(
                                context: context,
                                totalPrice: widget.totalPrice,
                              );
                          break;

                        case PaymentMethodType.cashOnDelivery:
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.successScreen,
                            arguments: {
                              "paymentId": "N/A",
                              "paymentMethod": "Cash On Delivery",
                              "status": "Pending",
                              "totalPrice": widget.totalPrice,
                            },
                          );
                          break;
                      }
                    },
                    child: Text(
                      "Continue",
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
