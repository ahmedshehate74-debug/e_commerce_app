import 'package:dartz/dartz.dart';

import '../entities/create_payment_intent_request_entity.dart';
import '../entities/create_payment_intent_response_entity.dart';
import '../failures.dart';
import '../repository/checkout_repository.dart';
 import 'package:injectable/injectable.dart';

@injectable
class CreatePaymentIntentUseCase {
  final CheckoutRepository repository;

  CreatePaymentIntentUseCase(this.repository);

  Future<Either<Failures, CreatePaymentIntentResponseEntity>> call(
    CreatePaymentIntentRequestEntity request,
  ) {
    return repository.createPaymentIntent(request);
  }
}