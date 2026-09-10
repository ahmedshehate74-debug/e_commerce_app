import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../domain/use_cases/get_all_products_use_case.dart';
import '../features/search/cubit/search_cubit.dart';
import 'di.config.dart'; // file will be generated

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

void configureDependencies() {
  getIt.init();
  if (!getIt.isRegistered<SearchCubit>()) {
    getIt.registerFactory<SearchCubit>(
      () => SearchCubit(getIt<GetAllProductsUseCase>()),
    );
  }
}