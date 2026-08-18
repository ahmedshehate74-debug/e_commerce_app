import 'package:flutter_e_commerce_c11_online/core/network/stripe_api_manager.dart';
import 'package:flutter_e_commerce_c11_online/core/network/stripe_end_points.dart';
import 'package:flutter_e_commerce_c11_online/data/data_sources/remote_data_source/checkout_remote_data_source.dart';
import 'package:flutter_e_commerce_c11_online/data/model/customer/customer_response_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/ephemeral_key/ephemeral_key_response_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/payment_intent/create_payment_intent_request_model.dart';
import 'package:flutter_e_commerce_c11_online/data/model/payment_intent/create_payment_intent_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutRemoteDataSourceImpl
    implements CheckoutRemoteDataSource {

  final StripeApiManager stripeApiManager;

  CheckoutRemoteDataSourceImpl(
    this.stripeApiManager,
  );

  @override
  Future<CustomerResponseModel> createCustomer() async {

    final response = await stripeApiManager.postData(
      StripeEndPoints.createCustomer,
      body: {},
    );

    return CustomerResponseModel.fromJson(
      response.data,
    );
  }

  @override
  Future<CreatePaymentIntentResponseModel> createPaymentIntent(
    PaymentIntentRequestModel request,
  ) async {

    final response = await stripeApiManager.postData(
      StripeEndPoints.createPaymentIntent,
      body: request.toJson(),
    );

    return CreatePaymentIntentResponseModel.fromJson(
      response.data,
    );
  }

  @override
  Future<EphemeralKeyResponseModel> createEphemeralKey(
    String customerId,
  ) async {

    final response = await stripeApiManager.postData(
      StripeEndPoints.createEphemeralKey,
      body: {
        "customer": customerId,
      },
      headers: {
        "Stripe-Version": "2025-07-30.basil",
      },
    );

    return EphemeralKeyResponseModel.fromJson(
      response.data,
    );
  }
}