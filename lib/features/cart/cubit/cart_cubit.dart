import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/delete_cart_item_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_cart_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/update_to_cart_%20use_case.dart';
import 'package:injectable/injectable.dart';
import 'cart_state.dart';
@injectable
class CartCubit extends Cubit<CartState> {

  final GetCartUseCase getCartUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;
  final UpdateCartCountUseCase updateCartCountUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.deleteCartItemUseCase, 
    required this.updateCartCountUseCase,
  }) : super(CartInitial());

  static CartCubit get(BuildContext context) =>
      BlocProvider.of<CartCubit>(context);

 Future<void> getCart() async {
  try {
    emit(CartLoading());

    final result = await getCartUseCase.invoke();

    print("بعد invoke");

   result.fold(
  (failure) {
    print("################################");
    print(failure.runtimeType);
    print(failure.errorMessage);
    print("################################");

    emit(CartError(failure));
  },
  (cart) {
    emit(CartSuccess(cart));
  },
);
  } catch (e, s) {
    print("======================");
    print(e);
    print(s);
    print("======================");
  }
}
 Future<void> deleteCartItem(String cartItemId) async {
  print("DELETE START");

  final result = await deleteCartItemUseCase.invoke(
    cartItemId: cartItemId,
  );

  print("DELETE FINISHED");

  result.fold(
    (failure) {
      print("DELETE FAILED");
      emit(CartError(failure));
    },
    (_) async {
      print("BEFORE GET CART");

      await getCart();

      print("AFTER GET CART");
    },
  );
}
Future<void> updateCartCount({
  required String cartItemId,
  required int count,
}) async {
  print("Cubit id = $cartItemId");
print("Cubit count = $count");
  final result = await updateCartCountUseCase.invoke(
    cartItemId: cartItemId,
    count: count,
  );

  result.fold(
  (failure) {
    emit(CartError(failure));
  },
  (cart) {
    emit(CartSuccess(cart));
  },
);
}
}
