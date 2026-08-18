import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/forget_password_use_cases.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/forget_password/cubit/forget_password_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordCubit({required this.forgetPasswordUseCase})
      : super(ForgetPasswordInitial());
  TextEditingController emailController = TextEditingController();
  void forgetPassword() async {
    emit(ForgetPasswordLoadingState());
    var either = await forgetPasswordUseCase.call(email: emailController.text);
    either.fold((l) {
      emit(ForgetPasswordErrorState(failures: l));
    }, (response) {
      emit(ForgetPasswordSuccessState(forgetPasswordEntity: response));
    });
  }
}
