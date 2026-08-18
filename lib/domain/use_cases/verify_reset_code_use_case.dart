import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/verify_reset_code_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/auth_repoistory.dart';
import 'package:injectable/injectable.dart';
@injectable
class VerifyResetCodeUseCase {
  AuthRepository repository;

  VerifyResetCodeUseCase({
    required this.repository,
  });

  Future<Either<Failures, VerifyResetCodeEntity>>
  call({
    required String resetCode,
  }) {
    return repository.verifyResetCode(
      resetCode: resetCode,
    );
  }
}