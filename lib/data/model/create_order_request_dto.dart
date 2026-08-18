class CreateOrderRequestDto {
  final String cartId;

  final String details;

  final String phone;

  final String city;

  CreateOrderRequestDto({
    required this.cartId,
    required this.details,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      "shippingAddress": {
        "details": details,
        "phone": phone,
        "city": city,
      }
    };
  }
}