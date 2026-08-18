

import 'package:flutter_e_commerce_c11_online/domain/entities/create_payment_intent_request_entity.dart';

class CreatePaymentIntentRequestDto
    extends CreatePaymentIntentRequestEntity {
  const CreatePaymentIntentRequestDto({
    required super.amount,
    required super.currency,
    required super.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "currency": currency,
      "customer": customerId,
    };
  }
}