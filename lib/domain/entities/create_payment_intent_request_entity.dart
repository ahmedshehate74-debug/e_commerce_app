class CreatePaymentIntentRequestEntity {
  final String amount;
  final String currency;
  final String customerId;

  const CreatePaymentIntentRequestEntity({
    required this.amount,
    required this.currency,
    required this.customerId,
  });
}