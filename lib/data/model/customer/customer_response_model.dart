class CustomerResponseModel {
  final String? id;

  const CustomerResponseModel({
    this.id,
  });

  factory CustomerResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CustomerResponseModel(
      id: json["id"],
    );
  }
}