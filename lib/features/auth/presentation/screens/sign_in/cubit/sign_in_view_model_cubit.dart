import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/log_in_use_cases.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/sign_in/cubit/sign_in_statets.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginScreenViewModel extends Cubit<LoginStates> {
  LoginUseCase loginUseCase;

  var emailController =
      TextEditingController(text: 'amira111@route.com');

  var passwordController =
      TextEditingController(text: 'Amira123');

  LoginScreenViewModel({
    required this.loginUseCase,
  }) : super(LoginInitialState());

  Future<void> login() async {
    emit(LoginLoadingState());

    print("1");

var either = await loginUseCase.invoke(
  email: emailController.text,
  password: passwordController.text,
);

print("2");
print(either);
    either.fold(
      (failure) {
        emit(LoginErrorState(failures: failure));
      },
      (response) async {
        /// ============================
        /// Save user data locally
        /// ============================

        await SharedPreferenceUtils.saveData(
          key: "token",
          value: response.token ?? "",
        );

        await SharedPreferenceUtils.saveData(
          key: "userName",
          value: response.user?.name ?? "",
        );

        await SharedPreferenceUtils.saveData(
          key: "userEmail",
          value: response.user?.email ?? "",
        );

        emit(
          LoginSuccessState(
            responseEntity: response,
          ),
        );
      },
    );
  }
}