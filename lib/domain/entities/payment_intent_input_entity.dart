class PaymentIntentInputEntity {
  final String amount;
  final String currency;
  final String customerId;

  const PaymentIntentInputEntity({
    required this.amount,
    required this.currency,
    required this.customerId,
  });
}