import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaypalService {
  Future<void> makePaypalPayment({
    required BuildContext context,
    required String clientId,
    required String secretKey,
    required double total,
    required void Function(
      String paymentId,
      String paymentMethod,
      String status,
    ) onSuccess,
    required VoidCallback onCancel,
    required void Function(dynamic error) onError,
  }) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PaypalCheckoutView(
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
                    "shipping_discount": 0,
                  },
                },

                "description": "E-Commerce Order",

                "item_list": {
                  "items": [
                    {
                      "name": "E-Commerce Products",
                      "quantity": 1,
                      "price": total.toStringAsFixed(2),
                      "currency": "USD",
                    },
                  ],
                },
              },
            ],

            note: "Thank you for your order.",

            onSuccess: (Map params) {
              log("PayPal Success: $params");

              final paymentId =
                  params["paymentId"]?.toString() ??
                  params["paymentID"]?.toString() ??
                  params["orderID"]?.toString() ??
                  params["id"]?.toString() ??
                  "N/A";

              final status =
                  params["status"]?.toString() ??
                  params["state"]?.toString() ??
                  "COMPLETED";

              onSuccess(
                paymentId,
                "PayPal",
                status,
              );
            },

            onError: (error) {
              log("PayPal Error: $error");

              onError(error);
            },

            onCancel: () {
              log("PayPal Cancelled");

              onCancel();
            },
          );
        },
      ),
    );
  }
}