
import 'package:flutter_e_commerce_c11_online/domain/entities/login_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginErrorState extends LoginStates{
  Failures failures ;
  LoginErrorState({required this.failures});
}
class LoginSuccessState extends LoginStates {
  LoginResponseEntity responseEntity ;
  LoginSuccessState({required this.responseEntity});
}