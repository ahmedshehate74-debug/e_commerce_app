class  CreatePaymentIntentResponseModel  {
  final String? id;
  final String? clientSecret;
  final String? status;

  CreatePaymentIntentResponseModel({
    this.id,
    this.clientSecret,
    this.status,
  });

  factory CreatePaymentIntentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return CreatePaymentIntentResponseModel(
      id: json["id"],
      clientSecret: json["client_secret"],
      status: json["status"],
    );
  }
}