import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/brand_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_details_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_page_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/sub_category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class HomeRepository {
Future<Either<Failures, List<CategoryEntity>>> getAllCategories();
Future<Either<Failures, List<BrandEntity>>> getAllBrands();
Future<Either<Failures, ProductPageEntity>> getAllProducts({required int page, String? subCategoryId});
Future<Either<Failures, ProductDetailsEntity>>
    getProductDetails({
  required String id,
});
Future<Either<Failures, String>> addToCart({
  required String productId,
});
Future<Either<Failures, CartEntity>> getCart();
Future<Either<Failures, String>> deleteCartItem({
  required String cartItemId,
});
Future<Either<Failures, CartEntity>> updateCartCount({
  required String cartItemId,
  required int count,
});
Future<Either<Failures, List<ProductEntity>>> getWishlist();

Future<Either<Failures, String>> removeWishlist({
  required String productId,
});

Future<Either<Failures, String>> addToWishlist({
  required String productId,
});

Future<Either<Failures, List<SubCategoryEntity>>> getSubCategories({
  required String categoryId,
});
Future<Either<Failures, ProductPageEntity>>
getProductsBySubCategory({
  required String subCategoryId,
});

}