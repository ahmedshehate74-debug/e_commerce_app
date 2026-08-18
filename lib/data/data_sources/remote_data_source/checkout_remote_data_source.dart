import 'package:flutter_e_commerce_c11_online/data/model/customer/customer_response_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/ephemeral_key/ephemeral_key_response_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/payment_intent/create_payment_intent_request_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/payment_intent/create_payment_intent_response_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<CustomerResponseModel> createCustomer();

  Future< CreatePaymentIntentResponseModel> createPaymentIntent(
    PaymentIntentRequestModel request,
  );

  Future<EphemeralKeyResponseModel> createEphemeralKey(
    String customerId,
  );
}