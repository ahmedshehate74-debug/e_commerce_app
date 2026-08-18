import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/forget_password_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/login_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/register_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/reset_password_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/verify_reset_code_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, RegisterResponseEntity>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });

  Future<Either<Failures, LoginResponseEntity>> login(
   {required String password, required String email}
  );
  Future<Either<Failures, ForgetPasswordREsponseEntity>> forgetPassword({
    required String email,
  });
  Future<Either<Failures, VerifyResetCodeEntity>>
verifyResetCode({
  required String resetCode,
});
Future<Either<Failures, ResetPasswordEntity>> resetPassword({
  required String email,
  required String newPassword,
});
}