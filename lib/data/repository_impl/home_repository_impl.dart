import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/brand_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_details_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_page_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/sub_category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<Either<Failures, List<CategoryEntity>>> getAllCategories() {
    return remote.getCategories();
  }

  @override
  Future<Either<Failures, List<BrandEntity>>> getAllBrands() {
    return remote.getBrands();
  }

  @override
  Future<Either<Failures, ProductPageEntity>> getAllProducts({
    required int page,
    String? subCategoryId,
    String? keyword,
    int? limit,
  }) {
    return remote.getAllProducts(
      page: page,
      subCategoryId: subCategoryId,
      keyword: keyword,
      limit: limit,
    );
  }

  @override
  Future<Either<Failures, ProductDetailsEntity>> getProductDetails(
      {required String id}) {
    return remote.getProductDetails(id: id);
  }

  @override
  Future<Either<Failures, String>> addToCart({
    required String productId,
  }) {
    return remote.addToCart(
      productId: productId,
    );
  }

  @override
  Future<Either<Failures, CartEntity>> getCart() {
    return remote.getCart();
  }

  @override
  Future<Either<Failures, String>> deleteCartItem({
    required String cartItemId,
  }) {
    return remote.deleteCartItem(
      cartItemId: cartItemId,
    );
  }

  @override
  Future<Either<Failures, CartEntity>> updateCartCount({
    required String cartItemId,
    required int count,
  }) {
    return remote.updateCartCount(
      cartItemId: cartItemId,
      count: count,
    );
  }

  @override
  Future<Either<Failures, List<ProductEntity>>> getWishlist() {
    return remote.getWishlist();
  }

  @override
  Future<Either<Failures, String>> removeWishlist({
    required String productId,
  }) {
    return remote.removeWishlist(
      productId: productId,
    );
  }

  @override
  Future<Either<Failures, String>> addToWishlist({
    required String productId,
  }) {
    return remote.addToWishlist(
      productId: productId,
    );
  }

  @override
  Future<Either<Failures, List<SubCategoryEntity>>> getSubCategories({
    required String categoryId,
  }) {
    return remote.getSubCategories(
      categoryId: categoryId,
    );
  }

  @override
  Future<Either<Failures, ProductPageEntity>> getProductsBySubCategory({
    required String subCategoryId,
  }) {
    return remote.getProductsBySubCategory(
      subCategoryId: subCategoryId,
    );
  }
}
