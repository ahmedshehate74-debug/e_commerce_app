import '../../domain/entities/brand_entity.dart';

class BrandDto {
  final String? id;
  final String? name;
  final String? image;

  BrandDto({
    this.id,
    this.name,
    this.image,
  });

  factory BrandDto.fromJson(Map<String, dynamic> json) {
    return BrandDto(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }

  BrandEntity toEntity() {
    return BrandEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
    );
  }
}