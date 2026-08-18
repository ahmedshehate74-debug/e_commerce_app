import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/reset_password_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/auth_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  AuthRepository repository;

  ResetPasswordUseCase({
    required this.repository,
  });

  Future<Either<Failures, ResetPasswordEntity>>
  call({
    required String email,
    required String newPassword,
  }) {
    return repository.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}