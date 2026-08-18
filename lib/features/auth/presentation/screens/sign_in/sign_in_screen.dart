import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/%20dialog_utils.dart';

import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';
import 'package:flutter_e_commerce_c11_online/di/di.dart';

import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/sign_in/cubit/sign_in_statets.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/sign_in/cubit/sign_in_view_model_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes_manager/routes.dart';
import '../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../core/widget/main_text_field.dart';
import '../../../../../core/widget/validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final LoginScreenViewModel viewModel = getIt<LoginScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenViewModel, LoginStates>(
      bloc: viewModel,
      listener: (context, state) async {
        if (state is LoginLoadingState) {
          DialogUtils.showLoading(
            context: context,
            message: 'Loading...',
          );
        } else if (state is LoginErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: state.failures.errorMessage,
            posActionName: 'OK',
          );
        } else if (state is LoginSuccessState) {
          print("1");

          DialogUtils.hideLoading(context);

          print("2");

          await SharedPreferenceUtils.saveData(
            key: "token",
            value: state.responseEntity.token ?? "",
          );

          print("3");

          await SharedPreferenceUtils.saveData(
            key: "userName",
            value: state.responseEntity.user?.name ?? "",
          );

          print("4");

          await SharedPreferenceUtils.saveData(
            key: "userEmail",
            value: state.responseEntity.user?.email ?? "",
          );

          print("5");

          print(SharedPreferenceUtils.getData(key: "token"));
          print(SharedPreferenceUtils.getData(key: "userName"));
          print(SharedPreferenceUtils.getData(key: "userEmail"));

          print("6");

          DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: 'Login Successfully',
            posActionName: 'OK',
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSize.s40.h),
                  Center(
                    child: SvgPicture.asset(SvgAssets.routeLogo),
                  ),
                  SizedBox(height: AppSize.s40.h),
                  Text(
                    'Welcome Back To Route',
                    style: getBoldStyle(color: ColorManager.white)
                        .copyWith(fontSize: FontSize.s24.sp),
                  ),
                  Text(
                    'Please sign in with your mail',
                    style: getLightStyle(color: ColorManager.white)
                        .copyWith(fontSize: FontSize.s16.sp),
                  ),
                  SizedBox(height: AppSize.s50.h),
                  BuildTextField(
                    controller: viewModel.emailController,
                    backgroundColor: ColorManager.white,
                    hint: 'enter your email',
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validation: AppValidators.validateEmail,
                  ),
                  SizedBox(height: AppSize.s28.h),
                  BuildTextField(
                    controller: viewModel.passwordController,
                    hint: 'enter your password',
                    backgroundColor: ColorManager.white,
                    label: 'Password',
                    isObscured: true,
                    textInputType: TextInputType.text,
                    validation: AppValidators.validatePassword,
                  ),
                  SizedBox(height: AppSize.s8.h),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.forgetPassword);
                          // Navigator.pushNamed(
                          //     context, Routes.forgetPasswordRoute);
                        },
                        child: Text(
                          'Forget password?',
                          style: getMediumStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s18.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s60.h),
                  Center(
                    child: SizedBox(
                      child: CustomElevatedButton(
                        isStadiumBorder: false,
                        label: 'Login',
                        backgroundColor: ColorManager.white,
                        textStyle: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: AppSize.s18,
                        ),
                        onTap: () {
                          viewModel.login();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: getSemiBoldStyle(color: ColorManager.white)
                            .copyWith(fontSize: FontSize.s16.sp),
                      ),
                      SizedBox(width: AppSize.s8.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signUpRoute);
                        },
                        child: Text(
                          'Create Account',
                          style: getSemiBoldStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s16.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
