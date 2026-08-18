class CreatePaymentIntentResponseDto {
  final String clientSecret;

  const CreatePaymentIntentResponseDto({
    required this.clientSecret,
  });

  factory CreatePaymentIntentResponseDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return CreatePaymentIntentResponseDto(
      clientSecret: json["client_secret"],
    );
  }
}