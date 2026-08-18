import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/use_cases/get_all_categories_usecase.dart';
import 'categories_state.dart';
@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategoriesUseCase useCase;

  CategoryCubit({required this.useCase})
      : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());

    final result = await useCase();

    result.fold(
      (error) => emit(CategoryError(error: error)),
      (categories) =>
          emit(CategorySuccess(categories: categories)),
    );
  }
}