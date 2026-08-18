import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/login_response_entity.dart';

import 'package:flutter_e_commerce_c11_online/domain/repository/auth_repoistory.dart';

import 'package:injectable/injectable.dart';

import '../failures.dart';

@injectable
class LoginUseCase {
  AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<Either<Failures, LoginResponseEntity>> invoke({
      required String email,
      required String password
  }){
    return authRepository.login(email: email, password: password);
  }
}