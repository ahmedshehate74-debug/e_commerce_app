import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/services/stripe_service.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/create_payment_intent_request_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_customer_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_ephemeral_key_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_order_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/create_payment_intent_use_case.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/cubit/checkout_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateCustomerUseCase createCustomerUseCase;
final CreatePaymentIntentUseCase createPaymentIntentUseCase;
final CreateEphemeralKeyUseCase createEphemeralKeyUseCase;
final StripeService stripeService;
final CreateOrderUseCase createOrderUseCase;

CheckoutCubit(
  this.createCustomerUseCase,
  this.createPaymentIntentUseCase,
  this.createEphemeralKeyUseCase,
  this.stripeService,
  this.createOrderUseCase,
) : super(const CheckoutState.initial());

  Future<void> makePayment(
    {  required String cartId,}
  ) async {

    emit(const CheckoutState.loading());

    final customerResult = await createCustomerUseCase();

    customerResult.fold(
      (failure) {
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

        ephemeralResult.fold(
          (failure) {
            emit(
              CheckoutState.failure(
                failure.errorMessage,
              ),
            );
          },
          (ephemeralKey) async {
            final paymentIntentResult = await createPaymentIntentUseCase(
                CreatePaymentIntentRequestEntity(
              amount: "1000",
              currency: "usd",
              customerId: customer.customerId,
            ));

            paymentIntentResult.fold(
              (failure) {
                emit(
                  CheckoutState.failure(
                    failure.errorMessage,
                  ),
                );
              },
              (paymentIntent) async {
                final paymentResult = await stripeService.makePayment(
                  clientSecret: paymentIntent.clientSecret,
                  customerId: customer.customerId,
                  ephemeralKeySecret: ephemeralKey.secret,
                );

               if (paymentResult) {
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
        const CheckoutState.success(),
      );
    },
  );
}
                else {
                  emit(
                    const CheckoutState.failure(
                      "Payment Cancelled",
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

}
