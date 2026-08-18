import 'package:flutter_e_commerce_c11_online/domain/entities/meta_data_entity.dart';



class MetadataDto {
  final int currentPage;
  final int numberOfPages;
  final int limit;
  final int? nextPage;

  MetadataDto({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    this.nextPage,
  });

  factory MetadataDto.fromJson(Map<String, dynamic> json) {
    return MetadataDto(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
      nextPage: json['nextPage'],
    );
  }

  MetadataEntity toEntity() {
    return MetadataEntity(
      currentPage: currentPage,
      numberOfPages: numberOfPages,
      limit: limit,
      nextPage: nextPage,
    );
  }
}