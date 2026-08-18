import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/register_response_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/auth_repoistory.dart';
import 'package:injectable/injectable.dart';
import '../failures.dart';
@injectable
class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failures, RegisterResponseEntity>> invoke({
  required String name,
  required String email,
  required String password,
  required String rePassword,
  required String phone,
}) async {
    return await authRepository.signUp(
      name: name,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }
}