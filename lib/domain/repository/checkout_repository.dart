import 'package:dartz/dartz.dart';

import '../entities/customer_entity.dart';
import '../entities/create_payment_intent_request_entity.dart';
import '../entities/create_payment_intent_response_entity.dart';
import '../entities/ephemeral_key_entity.dart';
import '../failures.dart';

abstract class CheckoutRepository {
  Future<Either<Failures, CustomerEntity>> createCustomer();

  Future<Either<Failures, CreatePaymentIntentResponseEntity>>
      createPaymentIntent(
    CreatePaymentIntentRequestEntity request,
  );

  Future<Either<Failures, EphemeralKeyEntity>>
      createEphemeralKey(
    String customerId,
  );
}