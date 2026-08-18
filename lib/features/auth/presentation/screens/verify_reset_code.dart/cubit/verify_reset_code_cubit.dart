import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/verify_reset_code.dart/cubit/verify_reset_code_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeStates> {
  VerifyResetCodeCubit(
    this.verifyResetCodeUseCase,
  ) : super(VerifyResetCodeInitialState());

  VerifyResetCodeUseCase verifyResetCodeUseCase;

  TextEditingController codeController = TextEditingController();

 Future<void> verifyCode() async {
  emit(VerifyResetCodeLoadingState());

  var result = await verifyResetCodeUseCase(
    resetCode: codeController.text.trim(),
  );

  result.fold(
    (error) {
      emit(
        VerifyResetCodeErrorState(error),
      );
    },
    (response) {
      emit(
        VerifyResetCodeSuccessState(response),
      );
    },
  );
}}