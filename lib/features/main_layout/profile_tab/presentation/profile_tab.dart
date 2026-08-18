import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widget/main_text_field.dart';
import '../../../../core/widget/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  bool isFullNameReadOnly = true;
  bool isEmailReadOnly = true;
  bool isPasswordReadOnly = true;
  bool isMobileNumberReadOnly = true;
  bool isAddressReadOnly = true;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

 @override
void initState() {
  super.initState();

  nameController = TextEditingController(
    text: SharedPreferenceUtils.getData(key: "userName")?.toString() ?? "",
  );

  emailController = TextEditingController(
    text: SharedPreferenceUtils.getData(key: "userEmail")?.toString() ?? "",
  );

  phoneController = TextEditingController(
    text: SharedPreferenceUtils.getData(key: "phone")?.toString() ?? "",
  );

  addressController = TextEditingController(
    text: SharedPreferenceUtils.getData(key: "address")?.toString() ?? "",
  );

  passwordController = TextEditingController();
}
  Future<void> saveProfile() async {
    await SharedPreferenceUtils.saveData(
      key: "userName",
      value: nameController.text,
    );

    await SharedPreferenceUtils.saveData(
      key: "userEmail",
      value: emailController.text,
    );

    await SharedPreferenceUtils.saveData(
      key: "phone",
      value: phoneController.text,
    );

    await SharedPreferenceUtils.saveData(
      key: "address",
      value: addressController.text,
    );
  }

  void disableEditing() {
    setState(() {
      isFullNameReadOnly = true;
      isEmailReadOnly = true;
      isMobileNumberReadOnly = true;
      isAddressReadOnly = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                SvgAssets.routeLogo,
                height: AppSize.s40,
                colorFilter: ColorFilter.mode(
                  ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: AppSize.s20.h),
              Text(
                nameController.text.isEmpty
    ? "Welcome"
    : "Welcome, ${nameController.text}",
                style: getSemiBoldStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
              ),
              Text(
                emailController.text,
                style: getRegularStyle(
                    color: ColorManager.primary.withOpacity(.5),
                    fontSize: FontSize.s14),
              ),
              SizedBox(height: AppSize.s18.h),
              BuildTextField(
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isFullNameReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your full name',
                label: 'Full Name',
                controller: nameController,
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(SvgAssets.edit),
                  onPressed: () {
                    setState(() {
                      isFullNameReadOnly = false;
                    });
                  },
                ),
                textInputType: TextInputType.text,
                validation: AppValidators.validateFullName,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: AppSize.s18.h),
              BuildTextField(
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isEmailReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your email address',
                label: 'E-mail address',
                controller: emailController,
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(SvgAssets.edit),
                  onPressed: () {
                    setState(() {
                      isEmailReadOnly = false;
                    });
                  },
                ),
                textInputType: TextInputType.emailAddress,
                validation: AppValidators.validateEmail,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: AppSize.s18.h),
              BuildTextField(
                onTap: () {
                  setState(() {
                    isPasswordReadOnly = false;
                  });
                },
                controller: passwordController,
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isPasswordReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your password',
                label: 'Password',
                isObscured: true,
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: SvgPicture.asset(SvgAssets.edit),
                textInputType: TextInputType.text,
                validation: AppValidators.validatePassword,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: AppSize.s18.h),
              BuildTextField(
                controller: phoneController,
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isMobileNumberReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your mobile no.',
                label: 'Your mobile number',
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(SvgAssets.edit),
                  onPressed: () {
                    setState(() {
                      isMobileNumberReadOnly = false;
                    });
                  },
                ),
                textInputType: TextInputType.phone,
                validation: AppValidators.validatePhoneNumber,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: AppSize.s18.h),
              BuildTextField(
                controller: addressController,
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isAddressReadOnly,
                backgroundColor: ColorManager.white,
                hint: '6th October, street 11.....',
                label: 'Your Address',
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(SvgAssets.edit),
                  onPressed: () {
                    setState(() {
                      isAddressReadOnly = false;
                    });
                  },
                ),
                textInputType: TextInputType.streetAddress,
                validation: AppValidators.validateFullName,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: AppSize.s20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await saveProfile();
print(SharedPreferenceUtils.getData(key: "userName"));
print(SharedPreferenceUtils.getData(key: "userEmail"));
print(SharedPreferenceUtils.getData(key: "phone"));
print(SharedPreferenceUtils.getData(key: "address"));
                    disableEditing();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Profile Updated"),
                        
                      ),
                    );
                  },
                  child: const Text("Save"),
                  
                ),
              ),
              SizedBox(height: AppSize.s50.h),
             
            ],
          ),
        ),
      ),
    );
  }
}
