class EphemeralKeyResponseModel {

  final String? id;
  final String? secret;

  const EphemeralKeyResponseModel({
    this.id,
    this.secret,
  });

  factory EphemeralKeyResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EphemeralKeyResponseModel(
      id: json["id"],
      secret: json["secret"],
    );
  }
}