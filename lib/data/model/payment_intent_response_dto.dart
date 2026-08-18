class PaymentIntentResponseDto {
  final String id;
  final String clientSecret;
  final String status;

  PaymentIntentResponseDto({
    required this.id,
    required this.clientSecret,
    required this.status,
  });

  factory PaymentIntentResponseDto.fromJson(Map<String, dynamic> json) {
    return PaymentIntentResponseDto(
      id: json["id"],
      clientSecret: json["client_secret"],
      status: json["status"],
    );
  }
}