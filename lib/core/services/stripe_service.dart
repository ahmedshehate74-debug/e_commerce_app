import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';

class StripePaymentResult {
  final String paymentId;
  final String status;

  const StripePaymentResult({
    required this.paymentId,
    required this.status,
  });
}

@injectable
class StripeService {
  Future<StripePaymentResult?> makePayment({
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

      // بعد نجاح الـ PaymentSheet نجيب الـ PaymentIntent الحقيقي
      final paymentIntent =
          await Stripe.instance.retrievePaymentIntent(clientSecret);

      return StripePaymentResult(
        paymentId: paymentIntent.id,
        status: paymentIntent.status.name,
      );
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        return null;
      }

      rethrow;
    }
  }
}