import 'package:flutter_e_commerce_c11_online/data/model/payment_intent/create_payment_intent_request_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/payment_intent/create_payment_intent_response_model.dart';

import '../../domain/entities/create_payment_intent_request_entity.dart';
import '../../domain/entities/create_payment_intent_response_entity.dart';



extension PaymentIntentRequestMapper
    on CreatePaymentIntentRequestEntity {

  PaymentIntentRequestModel toDto() {
    return PaymentIntentRequestModel(
      amount: amount,
      currency: currency,
      customerId: customerId,
    );
  }
}

extension PaymentIntentResponseMapper
    on  CreatePaymentIntentResponseModel {

  CreatePaymentIntentResponseEntity toEntity() {
    return CreatePaymentIntentResponseEntity(
      clientSecret: clientSecret ?? "",
    );
  }
}