import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/%20dialog_utils.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';
import 'package:flutter_e_commerce_c11_online/di/di.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/sign_up/cubit/sign_up_state.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/sign_up/cubit/sign_up_view_model_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes_manager/routes.dart';
import '../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../core/widget/main_text_field.dart';
import '../../../../../core/widget/validators.dart';
class SignUpScreen extends StatelessWidget {

  RegisterScreenViewModel viewModel = getIt<RegisterScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterScreenViewModel,RegisterStates> (
      bloc: viewModel,
      listener: (context,state) async{
        if(state is RegisterLoadingState){
          DialogUtils.showLoading(context: context, message: 'Loading...');
        }else if(state is RegisterErrorState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
              message: state.failures.errorMessage,
              posActionName: 'Ok',title: 'Error');
        }
        else if (state is RegisterSuccessState)  {
          DialogUtils.hideLoading(context);

          // await SharedPreferenceUtils.saveData(
          //   key: 'token',
          //   value: state.responseEntity.token,
          // );

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
                  SizedBox(
                    height: AppSize.s40.h,
                  ),
                  Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                  SizedBox(
                    height: AppSize.s40.h,
                  ),
                  BuildTextField(
                    backgroundColor: ColorManager.white,
                    hint: 'enter your full name',
                    label: 'Full Name',
                    textInputType: TextInputType.name,
                    validation: AppValidators.validateFullName,
                    controller: viewModel.nameController,
                  ),
                  SizedBox(
                    height: AppSize.s18.h,
                  ),
                  BuildTextField(
                    hint: 'enter your mobile no.',
                    backgroundColor: ColorManager.white,
                    label: 'Mobile Number',
                    validation: AppValidators.validatePhoneNumber,
                    textInputType: TextInputType.phone,
                    controller: viewModel.phoneController,
                  ),
                  SizedBox(
                    height: AppSize.s18.h,
                  ),
                  BuildTextField(
                    hint: 'enter your email address',
                    backgroundColor: ColorManager.white,
                    label: 'E-mail address',
                    validation: AppValidators.validateEmail,
                    textInputType: TextInputType.emailAddress,
                    controller: viewModel.emailController,
                  ),
                  SizedBox(
                    height: AppSize.s18.h,
                  ),
                  BuildTextField(
                    hint: 'enter your password',
                    backgroundColor: ColorManager.white,
                    label: 'password',
                    validation: AppValidators.validatePassword,
                    isObscured: true,
                    textInputType: TextInputType.text,
                    controller: viewModel.passwordController,
                  ),
                  SizedBox(
                    height: AppSize.s18.h,
                  ),
                  BuildTextField(
                    hint: 'enter your rePassword',
                    backgroundColor: ColorManager.white,
                    label: 'rePassword',
                    validation: AppValidators.validatePassword,
                    isObscured: true,
                    textInputType: TextInputType.text,
                    controller: viewModel.rePasswordController,
                  ),
                  SizedBox(
                    height: AppSize.s50.h,
                  ),
                  Center(
                    child: SizedBox(
                      height: AppSize.s60.h,
                      width: MediaQuery.of(context).size.width * .9,
                      child: CustomElevatedButton(
                        // borderRadius: AppSize.s8,
                        label: 'Sign Up',
                        backgroundColor: ColorManager.white,
                        textStyle: getBoldStyle(
                            color: ColorManager.primary, fontSize: AppSize.s20),
                        onTap: () {
                          viewModel.register();
                        
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
                            style: getBoldStyle(color: ColorManager.white),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}