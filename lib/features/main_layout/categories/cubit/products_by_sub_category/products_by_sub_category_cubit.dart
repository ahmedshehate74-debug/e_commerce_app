import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_products_by_sub_category_use_case.dart';
import 'package:injectable/injectable.dart';

import 'products_by_sub_category_state.dart';

@injectable
class ProductsBySubCategoryCubit
    extends Cubit<ProductsBySubCategoryState> {
  final GetProductsBySubCategoryUseCase useCase;

  ProductsBySubCategoryCubit(this.useCase)
      : super(ProductsBySubCategoryInitial());

  Future<void> getProducts({
    required String subCategoryId,
  }) async {
    emit(ProductsBySubCategoryLoading());

    final result = await useCase(
      subCategoryId: subCategoryId,
    );

    result.fold(
      (failure) {
        emit(
          ProductsBySubCategoryError(failure),
        );
      },
      (products) {
        emit(
          ProductsBySubCategorySuccess(products),
        );
      },
    );
  }
}