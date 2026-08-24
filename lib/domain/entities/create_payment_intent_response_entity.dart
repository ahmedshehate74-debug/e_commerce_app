class CreatePaymentIntentResponseEntity {
  final String id;
  final String clientSecret;
  final String status;

  const CreatePaymentIntentResponseEntity({
    required this.id,
    required this.clientSecret,
    required this.status,
  });
}