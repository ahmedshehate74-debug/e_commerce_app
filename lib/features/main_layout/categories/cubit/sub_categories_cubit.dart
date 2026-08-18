import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_sub_categories_use_case.dart';
import 'package:injectable/injectable.dart';
import 'sub_categories_state.dart';

@injectable
class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final GetSubCategoriesUseCase useCase;

  SubCategoriesCubit(this.useCase)
      : super(SubCategoriesInitial());

  Future<void> getSubCategories({
    required String categoryId,
  }) async {
    emit(SubCategoriesLoading());

    final result = await useCase.invoke(
      categoryId: categoryId,
    );

    result.fold(
      (failure) {
        emit(SubCategoriesError(failure));
      },
      (subCategories) {
        emit(
          SubCategoriesSuccess(subCategories),
        );
      },
    );
  }
}