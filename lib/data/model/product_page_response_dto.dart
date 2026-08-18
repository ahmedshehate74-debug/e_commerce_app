import 'package:flutter_e_commerce_c11_online/data/model/produect_dto.dart';

import '../../domain/entities/product_page_entity.dart';
import 'metadata_dto.dart';


class ProductPageResponseDto {
  final List<ProductDto> data;
  final MetadataDto metadata;

  ProductPageResponseDto({
    required this.data,
    required this.metadata,
  });

  factory ProductPageResponseDto.fromJson(
      Map<String, dynamic> json) {
    return ProductPageResponseDto(
      data: (json['data'] as List)
          .map((e) => ProductDto.fromJson(e))
          .toList(),
      metadata: MetadataDto.fromJson(
        json['metadata'],
      ),
    );
  }

  ProductPageEntity toEntity() {
    return ProductPageEntity(
      products: data
          .map((e) => e.toEntity())
          .toList(),

      currentPage: metadata.currentPage,

      numberOfPages: metadata.numberOfPages,

      nextPage: metadata.nextPage,
    );
  }
}