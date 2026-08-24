import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/network/api_keys.dart';
import 'package:flutter_e_commerce_c11_online/core/services/paypal_service.dart';
import 'package:flutter_e_commerce_c11_online/core/services/stripe_service.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/create_payment_intent_request_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_customer_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_ephemeral_key_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_payment_intent_use_case.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/cubit/checkout_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateCustomerUseCase createCustomerUseCase;
  final CreatePaymentIntentUseCase createPaymentIntentUseCase;
  final CreateEphemeralKeyUseCase createEphemeralKeyUseCase;
  final StripeService stripeService;
final PaypalService paypalService;
  // final CreateOrderUseCase createOrderUseCase;

CheckoutCubit(
  this.createCustomerUseCase,
  this.createPaymentIntentUseCase,
  this.createEphemeralKeyUseCase,
  this.stripeService,
  this.paypalService,
) : super(const CheckoutState.initial());

  Future<void> makePayment({
    required String cartId,
    required double totalPrice,
  }) async {
    emit(const CheckoutState.loading());

    final customerResult = await createCustomerUseCase();

    await customerResult.fold(
      (failure) async {
        emit(
          CheckoutState.failure(
            failure.errorMessage,
          ),
        );
      },
      (customer) async {
        final ephemeralResult = await createEphemeralKeyUseCase(
          customer.customerId,
        );

        await ephemeralResult.fold(
          (failure) async {
            emit(
              CheckoutState.failure(
                failure.errorMessage,
              ),
            );
          },
          (ephemeralKey) async {
            final amount = (totalPrice * 100).round().toString();

            final paymentIntentResult =
                await createPaymentIntentUseCase(
              CreatePaymentIntentRequestEntity(
                amount: amount,
                currency: "usd",
                customerId: customer.customerId,
              ),
            );

            await paymentIntentResult.fold(
              (failure) async {
                emit(
                  CheckoutState.failure(
                    failure.errorMessage,
                  ),
                );
              },
              (paymentIntent) async {
                try {
                  final paymentResult =
                      await stripeService.makePayment(
                    clientSecret: paymentIntent.clientSecret,
                    customerId: customer.customerId,
                    ephemeralKeySecret: ephemeralKey.secret,
                  );

                  if (paymentResult != null) {
                    // TODO: لما Route API يشتغل رجع الكود ده
                    /*
                    final orderResult =
                        await createOrderUseCase(cartId: cartId);

                    orderResult.fold(
                      (failure) {
                        emit(
                          CheckoutState.failure(
                            failure.errorMessage,
                          ),
                        );
                      },
                      (_) {
                        emit(
                          CheckoutState.success(
                            paymentId: paymentResult.paymentId,
                            paymentMethod: "Stripe",
                            status: paymentResult.status,
                          ),
                        );
                      },
                    );
                    */

                    emit(
                      CheckoutState.success(
                        paymentId: paymentResult.paymentId,
                        paymentMethod: "Stripe",
                        status: paymentResult.status,
                      ),
                    );
                  } else {
                    emit(
                      const CheckoutState.failure(
                        "Payment Cancelled",
                      ),
                    );
                  }
                } catch (e) {
                  emit(
                    CheckoutState.failure(
                      e.toString(),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
Future<void> makePaypalPayment({
  required BuildContext context,
  required double totalPrice,
}) async {
  await paypalService.makePaypalPayment(
    context: context,
    clientId: ApiKeys.paypalClientId,
    secretKey: ApiKeys.paypalSecretKey,
    total: totalPrice,

    onSuccess: (
      paymentId,
      paymentMethod,
      status,
    ) {
      emit(
        CheckoutState.success(
          paymentId: paymentId,
          paymentMethod: paymentMethod,
          status: status,
        ),
      );
    },

    onCancel: () {
      emit(
        const CheckoutState.failure(
          "Payment Cancelled",
        ),
      );
    },

    onError: (error) {
      emit(
        CheckoutState.failure(
          "PayPal Payment Failed: $error",
        ),
      );
    },
  );
}
}