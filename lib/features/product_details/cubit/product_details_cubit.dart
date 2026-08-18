import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_product_details_use_case.dart';
import 'package:injectable/injectable.dart';

import 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit({
    required this.getProductDetailsUseCase,
  }) : super(ProductDetailsInitial());

  Future<void> getProductDetails(String id) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetailsUseCase.invoke(
      id: id,
    );

    result.fold(
      (failure) {
        emit(
          ProductDetailsError(failure),
        );
      },
      (product) {
        emit(
          ProductDetailsSuccess(product),
        );
      },
    );
  }
}