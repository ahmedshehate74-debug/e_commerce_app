import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/add_to_cart_use_case.dart';
import 'add_to_cart_state.dart';

@injectable
class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUseCase addToCartUseCase;
  static AddToCartCubit get(BuildContext context) =>
      BlocProvider.of<AddToCartCubit>(context);

  AddToCartCubit({
    required this.addToCartUseCase,
  }) : super(AddToCartInitial());

  Future<void> addToCart(String productId) async {
    emit(AddToCartLoading());

    final result = await addToCartUseCase.invoke(
      productId: productId,
    );

    result.fold(
      (failure) {
        emit(
          AddToCartError(failure),
        );
      },
      (message) {
        emit(
          AddToCartSuccess(message),
        );
      },
    );
  }
}