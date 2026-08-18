import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/add_to_wishlist_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_wishlist_use_case.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/remove_wishlist_use_case.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/products_cubit.dart';
import 'package:injectable/injectable.dart';

import 'wishlist_state.dart';

@injectable
class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveWishlistUseCase removeWishlistUseCase;
  final Set<String> favouriteIds = {};

  WishlistCubit({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeWishlistUseCase,
  }) : super(WishlistInitial());

  static WishlistCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getWishlist() async {
    
    emit(WishlistLoading());

    final result = await getWishlistUseCase.invoke();
    

    result.fold((failure) {
      emit(WishlistError(failure));
    }, (products) {
      favouriteIds
        ..clear()
        ..addAll(products.map((e) => e.id));

      emit(WishlistSuccess(products));
    });
  }

  Future<void> addToWishlist( {
    required String productId,
  }) async {
    final result = await addToWishlistUseCase.invoke(
      productId: productId,
    );

    result.fold(
      (failure) {
        emit(WishlistError(failure));
      },
      (_) async {
        await getWishlist();
      },
    );
  }

  Future<void> removeWishlist({
    required String productId,
  }) async {
    final result = await removeWishlistUseCase.invoke(
      productId: productId,
    );

    result.fold(
      (failure) {
        emit(WishlistError(failure));
      },
      (_) async {
        await getWishlist();
      },
    );
  }
  bool isFavourite(String productId) {
  return favouriteIds.contains(productId);
}

}
