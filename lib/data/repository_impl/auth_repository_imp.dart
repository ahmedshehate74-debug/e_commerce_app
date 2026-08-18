import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/data/data_sources/remote_data_source/auth_remote_data_source.dart';

import 'package:flutter_e_commerce_c11_online/domain/entities/forget_password_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/login_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/register_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/reset_password_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/verify_reset_code_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/auth_repoistory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({required this.authRemoteDataSource});

 @override
Future<Either<Failures, RegisterResponseEntity>> signUp({
  required String name,
  required String email,
  required String password,
  required String rePassword,
  required String phone,
}) async {
  var either = await authRemoteDataSource.signUp(
    name: name,
    email: email,
    password: password,
    rePassword: rePassword,
    phone: phone,
  );

  return either.fold(
    (error) => Left(error),
    (response) => Right(response),
  );
}
  Future<Either<Failures,LoginResponseEntity>> login({
  required String email,
  required String password,
}) async{
    var either = await authRemoteDataSource.login(
      email: email,
      password: password,
      );
    return either.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }

  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, ForgetPasswordREsponseEntity>> forgetPassword({required String email}) async {
  var either = await authRemoteDataSource.forgetPassword(email: email);
  return either.fold(
    (error) => Left(error),
    (response) => Right(response),
  );  
  }
@override
Future<Either<Failures, VerifyResetCodeEntity>>
verifyResetCode({
  required String resetCode,
}) {
  return authRemoteDataSource.verifyResetCode(
    resetCode: resetCode,
  );
}
@override
Future<Either<Failures, ResetPasswordEntity>>
resetPassword({
  required String email,
  required String newPassword,
}) {
  return authRemoteDataSource.resetPassword(
    email: email,
    newPassword: newPassword,
  );
}
 
  
}
