import 'package:flutter_e_commerce_c11_online/domain/entities/verify_reset_code_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class VerifyResetCodeStates {}

class VerifyResetCodeInitialState
    extends VerifyResetCodeStates {}

class VerifyResetCodeLoadingState
    extends VerifyResetCodeStates {}

class VerifyResetCodeSuccessState
    extends VerifyResetCodeStates {
  VerifyResetCodeEntity verifyResetCodeEntity
    ;

  VerifyResetCodeSuccessState(this.verifyResetCodeEntity);
}

class VerifyResetCodeErrorState
    extends VerifyResetCodeStates {
  Failures failure;

  VerifyResetCodeErrorState(this.failure);
}