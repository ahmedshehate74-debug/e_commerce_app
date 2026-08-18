import 'package:flutter_e_commerce_c11_online/domain/entities/forget_password_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class ForgetPasswordStates {}

class ForgetPasswordInitial extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}
class ForgetPasswordSuccessState extends ForgetPasswordStates {
  ForgetPasswordREsponseEntity forgetPasswordEntity;
  ForgetPasswordSuccessState({required this.forgetPasswordEntity, });
}
class ForgetPasswordErrorState extends ForgetPasswordStates {
  Failures failures;
  ForgetPasswordErrorState({required this.failures});
}