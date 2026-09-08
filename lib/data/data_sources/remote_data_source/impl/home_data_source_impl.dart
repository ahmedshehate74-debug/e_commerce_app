import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/data/api_manager.dart';
import 'package:flutter_e_commerce_c11_online/data/end_points.dart';
import 'package:flutter_e_commerce_c11_online/data/model/brand_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/cart_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/category_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/product_details_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/product_page_response_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/sub_category_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/wishlist_dto.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/brand_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_details_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/product_page_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/produect_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/sub_category_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:injectable/injectable.dart';
import '../home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeDataSourceImpl implements HomeRemoteDataSource {
  final ApiManager apiManager;

  HomeDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await apiManager.getData(
        EndPoints.getAllCategories,
      );

      final result = (response.data['data'] as List)
          .map((e) => CategoryDto.fromJson(e).toEntity())
          .toList();

      return Right(result);
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<BrandEntity>>> getBrands() async {
    try {
      final response = await apiManager.getData(
        EndPoints.getAllBrands,
      );

      final result = (response.data['data'] as List)
          .map(
            (e) => BrandDto.fromJson(e).toEntity(),
          )
          .toList();

      return Right(result);
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

 @override
Future<Either<Failures, ProductPageEntity>> getAllProducts({
  required int page,
  String? subCategoryId,
  String? keyword,
}) async {
  try {
    print("========== GET PRODUCTS ==========");
    print({
      "page": page,
      "subcategory": subCategoryId,
      "keyword": keyword,
    });

    final response = await apiManager.getData(
      EndPoints.getAllProducts,
      queryParameters: {
        "page": page,
        if (subCategoryId != null)
          "subcategory": subCategoryId,
        if (keyword != null && keyword.trim().isNotEmpty)
          "keyword": keyword.trim(),
      },
    );

    print("URL = ${response.requestOptions.uri}");

    final result =
        ProductPageResponseDto.fromJson(response.data);

    return Right(result.toEntity());
  } catch (e) {
    print("ERROR = $e");

    return Left(
      UnexpectedError(
        errorMessage: e.toString(),
      ),
    );
  }
}
  @override
  Future<Either<Failures, ProductDetailsEntity>> getProductDetails({
    required String id,
  }) async {
    try {
      final response = await apiManager.getData(
        "${EndPoints.getSpecificProduct}/$id",
      );

      final result = ProductDetailsDto.fromJson(
        response.data["data"],
      );

      return Right(result.toEntity());
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, String>> addToCart({
    required String productId,
  }) async {
    try {
      final response = await apiManager.postData(
        EndPoints.addToCart,
        body: {
          "productId": productId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data["message"]);
      }

      return Left(
        ServerError(
          errorMessage: response.data["message"],
        ),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, CartEntity>> getCart() async {
    try {
      final response = await apiManager.getData(
        EndPoints.getCart,
      );

      final result = CartDto.fromJson(response.data);

      final entity = result.toEntity();

      return Right(entity);
    } catch (e, s) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, String>> deleteCartItem({
    required String cartItemId,
  }) async {
    try {
      final response = await apiManager.deleteData(
        "${EndPoints.getCart}/$cartItemId",
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      }

      return Left(
        ServerError(
          errorMessage: response.data["message"],
        ),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, CartEntity>> updateCartCount({
    required String cartItemId,
    required int count,
  }) async {
    try {
      final response = await apiManager.putData(
        "${EndPoints.updateCart}/$cartItemId",
        body: {
          "count": count,
        },
      );

      if (response.statusCode == 200) {
        final cart = CartDto.fromJson(response.data);

        return Right(cart.toEntity());
      }

      return Left(
        ServerError(
          errorMessage: response.data["message"],
        ),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, String>> addToWishlist({
    required String productId,
  }) async {
    try {
      final response = await apiManager.postData(
        EndPoints.wishlist,
        body: {
          "productId": productId,
        },
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      }

      return Left(
        ServerError(
          errorMessage: response.data["message"],
        ),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<ProductEntity>>> getWishlist() async {
    try {
      final response = await apiManager.getData(
        EndPoints.wishlist,
      );

      final result = WishlistDto.fromJson(response.data);

      return Right(result.toEntity());
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, String>> removeWishlist({
    required String productId,
  }) async {
    try {
      final response = await apiManager.deleteData(
        "${EndPoints.wishlist}/$productId",
      );

      if (response.statusCode == 200) {
        return Right(
          response.data["message"],
        );
      }

      return Left(
        ServerError(
          errorMessage: response.data["message"],
        ),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<SubCategoryEntity>>> getSubCategories({
    required String categoryId,
  }) async {
    try {
      final response = await apiManager.getData(
        "${EndPoints.getAllCategories}/$categoryId/subcategories",
      );

      final result = (response.data["data"] as List)
          .map(
            (e) => SubCategoryDto.fromJson(e).toEntity(),
          )
          .toList();

      return Right(result);
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, ProductPageEntity>> getProductsBySubCategory({
    required String subCategoryId,
  }) async {
    try {
      final response = await apiManager.getData(
        EndPoints.getAllProducts,
        queryParameters: {
          "subcategory": subCategoryId,
        },
      );

      final result = ProductPageResponseDto.fromJson(response.data);
      return Right(result.toEntity());
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
