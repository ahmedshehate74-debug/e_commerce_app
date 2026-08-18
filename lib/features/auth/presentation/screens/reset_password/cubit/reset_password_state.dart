import 'package:flutter_e_commerce_c11_online/domain/entities/reset_password_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitialState
    extends ResetPasswordState {}

class ResetPasswordLoadingState
    extends ResetPasswordState {}

class ResetPasswordSuccessState
    extends ResetPasswordState {
  ResetPasswordEntity resetPasswordEntity;

  ResetPasswordSuccessState(this.resetPasswordEntity);
}

class ResetPasswordErrorState
    extends ResetPasswordState {
  Failures failure;

  ResetPasswordErrorState({
    required this.failure,
  });
}