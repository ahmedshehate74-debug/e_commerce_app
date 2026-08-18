import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/resources/color_manager.dart';
import 'package:flutter_e_commerce_c11_online/core/resources/styles_manager.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/%20dialog_utils.dart';

import 'package:flutter_e_commerce_c11_online/core/widget/custom_elevated_button.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/main_text_field.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/validators.dart';
import 'package:flutter_e_commerce_c11_online/di/di.dart';

import 'cubit/reset_password_cubit.dart';
import 'cubit/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {


  ResetPasswordScreen({super.key, });

  final ResetPasswordCubit viewModel = getIt<ResetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
  
viewModel.emailController.text =
    SharedPreferenceUtils.getData(
          key: "resetEmail",
        )?.toString() ??
        "";
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          DialogUtils.showLoading(
            context: context,
            message: "Loading...",
          );
        }

        if (state is ResetPasswordErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: "Error",
            message: state.failure.errorMessage,
            posActionName: "OK",
          );
        }

       if (state is ResetPasswordSuccessState) {
  DialogUtils.hideLoading(context);

  DialogUtils.showMessage(
    context: context,
    title: "Success",
    message: "Password changed successfully",
    posActionName: "Continue",
    posAction: () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.mainRoute,
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
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("Reset Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Text(
                "Create New Password",
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 40),

              BuildTextField(
                backgroundColor: ColorManager.white,
                hint: "Email",
                label: "Email",
                controller: viewModel.emailController,
                enabled: false,
              ),

              const SizedBox(height: 20),

              BuildTextField(
                backgroundColor: ColorManager.white,
                hint: "New Password",
                label: "Password",
                isObscured: true,
                validation: AppValidators.validatePassword,
                controller: viewModel.passwordController,
              ),

              const SizedBox(height: 20),

              BuildTextField(
                backgroundColor: ColorManager.white,
                hint: "Confirm Password",
                label: "Confirm Password",
                isObscured: true,
                validation: AppValidators.validatePassword,
                controller: viewModel.confirmPasswordController,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  label: "Reset Password",
                  backgroundColor: Colors.white,
                  textStyle: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: 18,
                  ),
                  onTap: () {
                    viewModel.resetPassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}