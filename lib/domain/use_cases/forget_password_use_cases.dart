import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/forget_password_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/auth_repoistory.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordUseCase {
   AuthRepository authRepository;

  ForgetPasswordUseCase({required this.authRepository});

  Future<Either<Failures, ForgetPasswordREsponseEntity>> call({
    required String email,
  }) async {
    return await authRepository.forgetPassword(email: email);
  }
}