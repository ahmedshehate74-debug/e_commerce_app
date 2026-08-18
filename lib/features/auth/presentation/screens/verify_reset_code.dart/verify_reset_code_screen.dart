import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/resources/color_manager.dart';
import 'package:flutter_e_commerce_c11_online/core/resources/styles_manager.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/%20dialog_utils.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/custom_elevated_button.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/main_text_field.dart';
import 'package:flutter_e_commerce_c11_online/di/di.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/verify_reset_code.dart/cubit/verify_reset_code_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/verify_reset_code.dart/cubit/verify_reset_code_state.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  VerifyResetCodeScreen({super.key});

  final VerifyResetCodeCubit viewModel = getIt<VerifyResetCodeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyResetCodeCubit, VerifyResetCodeStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is VerifyResetCodeLoadingState) {
          DialogUtils.showLoading(
            context: context,
            message: "Loading...",
          );
        } else if (state is VerifyResetCodeErrorState) {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
            context: context,
            title: "Error",
            message: state.failure.errorMessage,
            posActionName: "OK",
          );
        } else if (state is VerifyResetCodeSuccessState) {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
            context: context,
            title: "Success",
            message: "Code Verified Successfully",
            posActionName: "Continue",
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.resetPasswordRoute,
                (route) => false,
              );
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Verify Code",
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter the code sent to your email",
                  style: getLightStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                BuildTextField(
                  backgroundColor: Colors.white,
                  hint: "Enter Code",
                  label: "Code",
                  textInputType: TextInputType.number,
                  controller: viewModel.codeController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    label: "Verify",
                    backgroundColor: Colors.white,
                    textStyle: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 18,
                    ),
                    onTap: () {
                      if (viewModel.codeController.text.trim().isEmpty) {
                        DialogUtils.showMessage(
                          context: context,
                          title: "Error",
                          message: "Please Enter Code",
                          posActionName: "OK",
                        );
                        return;
                      }

                      viewModel.verifyCode();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
