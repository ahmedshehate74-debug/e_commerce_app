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
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/forget_password/cubit/foret_password_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/forget_password/cubit/forget_password_states.dart';



// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

   ForgetPasswordCubit viewModel = getIt<ForgetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ForgetPasswordLoadingState) {
          DialogUtils.showLoading(
              context: context, message: "Loading...");
        }

        if (state is ForgetPasswordErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: "Error",
            message: state.failures.errorMessage,
            posActionName: "Ok",
          );
        }

        if (state is ForgetPasswordSuccessState) {
  DialogUtils.hideLoading(context);

  DialogUtils.showMessage(
    context: context,
    title: 'Success',
    message: state.forgetPasswordEntity.message ?? '',
    posActionName: 'OK',
    posAction: () {
      Navigator.pushNamed(
        context,
        Routes.verifyResetCode,
      );

      SharedPreferenceUtils.saveData(
        key: 'resetEmail',
        value: viewModel.emailController.text,
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
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Text(
                  "Forget Password",
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 26,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Enter your email to receive reset code",
                  style: getLightStyle(
                    color: ColorManager.white,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                BuildTextField(
                  backgroundColor: ColorManager.white,
                  hint: "Enter your email",
                  label: "Email",
                  textInputType: TextInputType.emailAddress,
                  validation: AppValidators.validateEmail,
                  controller: viewModel.emailController,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    label: "Send Code",
                    backgroundColor: ColorManager.white,
                    textStyle: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 18,
                    ),
                    onTap: () {
                      viewModel.forgetPassword();
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