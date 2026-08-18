class PaymentIntentRequestModel {
  final String amount;
  final String currency;
  final String customerId;

  const PaymentIntentRequestModel({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "currency": currency,
      "customer": customerId,
    };
  }
}