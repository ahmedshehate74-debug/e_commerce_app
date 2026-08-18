import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/reset_password_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/reset_password/cubit/reset_password_state.dart';
import 'package:injectable/injectable.dart';
@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({required this.useCase})
      : super(ResetPasswordInitialState());

   ResetPasswordUseCase useCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    // 🧠 validation بسيطة قبل API
    if (passwordController.text != confirmPasswordController.text) {
      emit(
        ResetPasswordErrorState(
        failure: UnexpectedError(
            errorMessage: "Passwords do not match",
          ),
        ),
      );
      return;
    }

    emit(ResetPasswordLoadingState());

    final result = await useCase.call(
      email: emailController.text.trim(),
      newPassword: passwordController.text.trim(),
    );

    result.fold(
      (error) {
        emit(ResetPasswordErrorState(failure: error));
      },
      (response) async {
        // 💾 لو فيه token احفظه
        if (response.token != null) {
          await SharedPreferenceUtils.saveData(
            key: "token",
            value: response.token,
          );
        }

        emit(ResetPasswordSuccessState(response));
      },
    );
  }
}