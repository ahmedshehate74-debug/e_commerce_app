class CustomerResponseDto {
  final String? id;

  CustomerResponseDto({
    this.id,
  });

  factory CustomerResponseDto.fromJson(Map<String, dynamic> json) {
    return CustomerResponseDto(
      id: json['id'],
    );
  }
}