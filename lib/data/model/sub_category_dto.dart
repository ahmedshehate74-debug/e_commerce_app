import '../../domain/entities/sub_category_entity.dart';

class SubCategoryDto {
  final String id;
  final String name;
  final String categoryId;

  SubCategoryDto({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  factory SubCategoryDto.fromJson(Map<String, dynamic> json) {
    return SubCategoryDto(
      id: json['_id'],
      name: json['name'],
      categoryId: json['category'],
    );
  }

  SubCategoryEntity toEntity() {
    return SubCategoryEntity(
      id: id,
      name: name,
      categoryId: categoryId,
    );
  }
}