import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_all_brands_usecase.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/brand_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class BrandCubit extends Cubit<BrandState> {
  final GetAllBrandsUseCase useCase;

  BrandCubit(this.useCase) : super(BrandInitial());

  Future<void> getBrands() async {
    emit(BrandLoading());

    final result = await useCase();

    result.fold(
      (failures) {
        emit(
          BrandError(failures: failures,),
        );
      },
      (brands) {
        emit(
          BrandSuccess(brands: brands),
        );
      },
    );
  }
}