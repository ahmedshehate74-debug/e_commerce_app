import 'package:dartz/dartz.dart';

import '../entities/ephemeral_key_entity.dart';
import '../failures.dart';
import '../repository/checkout_repository.dart';
 import 'package:injectable/injectable.dart';

@injectable
class CreateEphemeralKeyUseCase {
  final CheckoutRepository repository;

  CreateEphemeralKeyUseCase(this.repository);

  Future<Either<Failures, EphemeralKeyEntity>> call(
    String customerId,
  ) {
    return repository.createEphemeralKey(customerId);
  }
}