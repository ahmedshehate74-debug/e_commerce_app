import '../../domain/entities/category_entity.dart';

class CategoryDto {
  final String id;
  final String name;
  final String image;

  CategoryDto({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      image: image,
    );
  }
}