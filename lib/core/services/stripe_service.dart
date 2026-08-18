import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';

@injectable
class StripeService {

  Future<bool> makePayment({
    required String clientSecret,
    required String customerId,
    required String ephemeralKeySecret,
  }) async {

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: "Ahmed Shehata E-Commerce",

        paymentIntentClientSecret: clientSecret,

        customerId: customerId,

        customerEphemeralKeySecret: ephemeralKeySecret,
      ),
    );

    try {

      await Stripe.instance.presentPaymentSheet();

      return true;

    } on StripeException catch (e) {

      if (e.error.code == FailureCode.Canceled) {
        return false;
      }

      rethrow;
    }
  }
}