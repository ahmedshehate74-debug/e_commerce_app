import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaypalService {
  Future<void> makePaypalPayment({
    required BuildContext context,
    required String clientId,
    required String secretKey,
    required double total,
    required VoidCallback onSuccess,
    required VoidCallback onCancel,
    required Function(dynamic) onError,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaypalCheckoutView(
          sandboxMode: true,

          clientId: clientId,

          secretKey: secretKey,

          transactions: [
            {
              "amount": {
                "total": total.toStringAsFixed(2),
                "currency": "USD",
                "details": {
                  "subtotal": total.toStringAsFixed(2),
                  "shipping": "0",
                  "shipping_discount": 0
                }
              },
              "description": "E-Commerce Order",
              "item_list": {
                "items": [
                  {
                    "name": "Products",
                    "quantity": 1,
                    "price": total.toStringAsFixed(2),
                    "currency": "USD",
                  }
                ]
              }
            }
          ],

          note: "Thanks",

          onSuccess: (params) {
            onSuccess();
          },

          onError: (error) {
            onError(error);
          },

          onCancel: () {
            onCancel();
          },
        ),
      ),
    );
  }
}