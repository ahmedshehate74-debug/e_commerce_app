// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/network/stripe_api_manager.dart' as _i271;
import '../core/services/paypal_service.dart' as _i662;
import '../core/services/stripe_service.dart' as _i578;
import '../data/api_manager.dart' as _i704;
import '../data/data_sources/remote_data_source/auth_remote_data_source.dart'
    as _i384;
import '../data/data_sources/remote_data_source/checkout_remote_data_source.dart'
    as _i774;
import '../data/data_sources/remote_data_source/home_remote_data_source.dart'
    as _i404;
import '../data/data_sources/remote_data_source/impl/auth_remote_data_source_impl.dart'
    as _i447;
import '../data/data_sources/remote_data_source/impl/checkout_remote_data_source_impl.dart'
    as _i779;
import '../data/data_sources/remote_data_source/impl/home_data_source_impl.dart'
    as _i77;
import '../data/repository_impl/auth_repository_imp.dart' as _i719;
import '../data/repository_impl/checkout_remote_data_source_impl.dart' as _i425;
import '../data/repository_impl/home_repository_impl.dart' as _i24;
import '../domain/repository/auth_repoistory.dart' as _i430;
import '../domain/repository/checkout_repository.dart' as _i6;
import '../domain/repository/home_repoistory.dart' as _i653;
import '../domain/use_cases/add_to_cart_use_case.dart' as _i994;
import '../domain/use_cases/add_to_wishlist_use_case.dart' as _i168;
import '../domain/use_cases/create_customer_use_case.dart' as _i649;
import '../domain/use_cases/create_ephemeral_key_use_case.dart' as _i480;
import '../domain/use_cases/create_payment_intent_use_case.dart' as _i577;
import '../domain/use_cases/delete_cart_item_use_case.dart' as _i914;
import '../domain/use_cases/forget_password_use_cases.dart' as _i218;
import '../domain/use_cases/get_all_brands_usecase.dart' as _i436;
import '../domain/use_cases/get_all_categories_usecase.dart' as _i51;
import '../domain/use_cases/get_all_products_use_case.dart' as _i960;
import '../domain/use_cases/get_cart_use_case.dart' as _i487;
import '../domain/use_cases/get_product_details_use_case.dart' as _i529;
import '../domain/use_cases/get_products_by_sub_category_use_case.dart'
    as _i942;
import '../domain/use_cases/get_sub_categories_use_case.dart' as _i356;
import '../domain/use_cases/get_wishlist_use_case.dart' as _i861;
import '../domain/use_cases/home_use_case.dart' as _i981;
import '../domain/use_cases/log_in_use_cases.dart' as _i806;
import '../domain/use_cases/register_use_case.dart' as _i772;
import '../domain/use_cases/remove_wishlist_use_case.dart' as _i1043;
import '../domain/use_cases/reset_password_use_case.dart' as _i730;
import '../domain/use_cases/update_to_cart_%20use_case.dart' as _i190;
import '../domain/use_cases/verify_reset_code_use_case.dart' as _i919;
import '../features/auth/presentation/screens/forget_password/cubit/foret_password_cubit.dart'
    as _i81;
import '../features/auth/presentation/screens/reset_password/cubit/reset_password_cubit.dart'
    as _i287;
import '../features/auth/presentation/screens/sign_in/cubit/sign_in_view_model_cubit.dart'
    as _i364;
import '../features/auth/presentation/screens/sign_up/cubit/sign_up_view_model_cubit.dart'
    as _i640;
import '../features/auth/presentation/screens/verify_reset_code.dart/cubit/verify_reset_code_cubit.dart'
    as _i742;
import '../features/cart/cubit/cart_cubit.dart' as _i291;
import '../features/check_out/cubit/checkout_cubit.dart' as _i103;
import '../features/main_layout/brand/cubit/brand_cubit.dart' as _i304;
import '../features/main_layout/categories/cubit/products_by_sub_category/products_by_sub_category_cubit.dart'
    as _i294;
import '../features/main_layout/categories/cubit/sub_categories_cubit.dart'
    as _i202;
import '../features/main_layout/cubit/categories_cubit.dart' as _i483;
import '../features/main_layout/home/cubit/products_cubit.dart' as _i762;
import '../features/product_details/cubit/product_details_cubit.dart' as _i730;
import '../features/product_details/presentation/cubit/add_to_cart_cubit.dart'
    as _i1007;
import '../features/wishlist/cubit/wishlist_cubit.dart' as _i1013;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i662.PaypalService>(() => _i662.PaypalService());
    gh.factory<_i578.StripeService>(() => _i578.StripeService());
    gh.singleton<_i271.StripeApiManager>(() => _i271.StripeApiManager());
    gh.singleton<_i704.ApiManager>(() => _i704.ApiManager());
    gh.factory<_i774.CheckoutRemoteDataSource>(
        () => _i779.CheckoutRemoteDataSourceImpl(gh<_i271.StripeApiManager>()));
    gh.factory<_i6.CheckoutRepository>(() =>
        _i425.CheckoutRepositoryImpl(gh<_i774.CheckoutRemoteDataSource>()));
    gh.factory<_i649.CreateCustomerUseCase>(
        () => _i649.CreateCustomerUseCase(gh<_i6.CheckoutRepository>()));
    gh.factory<_i480.CreateEphemeralKeyUseCase>(
        () => _i480.CreateEphemeralKeyUseCase(gh<_i6.CheckoutRepository>()));
    gh.factory<_i577.CreatePaymentIntentUseCase>(
        () => _i577.CreatePaymentIntentUseCase(gh<_i6.CheckoutRepository>()));
    gh.lazySingleton<_i384.AuthRemoteDataSource>(() =>
        _i447.AuthRemoteDataSourceImpl(apiManager: gh<_i704.ApiManager>()));
    gh.lazySingleton<_i404.HomeRemoteDataSource>(
        () => _i77.HomeDataSourceImpl(apiManager: gh<_i704.ApiManager>()));
    gh.factory<_i430.AuthRepository>(() => _i719.AuthRepositoryImp(
        authRemoteDataSource: gh<_i384.AuthRemoteDataSource>()));
    gh.factory<_i653.HomeRepository>(
        () => _i24.HomeRepositoryImpl(gh<_i404.HomeRemoteDataSource>()));
    gh.factory<_i103.CheckoutCubit>(() => _i103.CheckoutCubit(
          gh<_i649.CreateCustomerUseCase>(),
          gh<_i577.CreatePaymentIntentUseCase>(),
          gh<_i480.CreateEphemeralKeyUseCase>(),
          gh<_i578.StripeService>(),
          gh<_i662.PaypalService>(),
        ));
    gh.factory<_i994.AddToCartUseCase>(
        () => _i994.AddToCartUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i168.AddToWishlistUseCase>(() =>
        _i168.AddToWishlistUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i914.DeleteCartItemUseCase>(() =>
        _i914.DeleteCartItemUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i51.GetAllCategoriesUseCase>(() =>
        _i51.GetAllCategoriesUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i487.GetCartUseCase>(
        () => _i487.GetCartUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i529.GetProductDetailsUseCase>(() =>
        _i529.GetProductDetailsUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i861.GetWishlistUseCase>(
        () => _i861.GetWishlistUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i981.HomeUseCase>(
        () => _i981.HomeUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i1043.RemoveWishlistUseCase>(() =>
        _i1043.RemoveWishlistUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i190.UpdateCartCountUseCase>(() =>
        _i190.UpdateCartCountUseCase(repository: gh<_i653.HomeRepository>()));
    gh.factory<_i218.ForgetPasswordUseCase>(() => _i218.ForgetPasswordUseCase(
        authRepository: gh<_i430.AuthRepository>()));
    gh.factory<_i806.LoginUseCase>(
        () => _i806.LoginUseCase(authRepository: gh<_i430.AuthRepository>()));
    gh.factory<_i772.RegisterUseCase>(() =>
        _i772.RegisterUseCase(authRepository: gh<_i430.AuthRepository>()));
    gh.factory<_i1007.AddToCartCubit>(() =>
        _i1007.AddToCartCubit(addToCartUseCase: gh<_i994.AddToCartUseCase>()));
    gh.factory<_i81.ForgetPasswordCubit>(() => _i81.ForgetPasswordCubit(
        forgetPasswordUseCase: gh<_i218.ForgetPasswordUseCase>()));
    gh.factory<_i436.GetAllBrandsUseCase>(
        () => _i436.GetAllBrandsUseCase(gh<_i653.HomeRepository>()));
    gh.factory<_i960.GetAllProductsUseCase>(
        () => _i960.GetAllProductsUseCase(gh<_i653.HomeRepository>()));
    gh.factory<_i942.GetProductsBySubCategoryUseCase>(() =>
        _i942.GetProductsBySubCategoryUseCase(gh<_i653.HomeRepository>()));
    gh.factory<_i356.GetSubCategoriesUseCase>(
        () => _i356.GetSubCategoriesUseCase(gh<_i653.HomeRepository>()));
    gh.factory<_i640.RegisterScreenViewModel>(() =>
        _i640.RegisterScreenViewModel(
            registerUseCase: gh<_i772.RegisterUseCase>()));
    gh.factory<_i730.ResetPasswordUseCase>(() =>
        _i730.ResetPasswordUseCase(repository: gh<_i430.AuthRepository>()));
    gh.factory<_i919.VerifyResetCodeUseCase>(() =>
        _i919.VerifyResetCodeUseCase(repository: gh<_i430.AuthRepository>()));
    gh.factory<_i304.BrandCubit>(
        () => _i304.BrandCubit(gh<_i436.GetAllBrandsUseCase>()));
    gh.factory<_i1013.WishlistCubit>(() => _i1013.WishlistCubit(
          getWishlistUseCase: gh<_i861.GetWishlistUseCase>(),
          addToWishlistUseCase: gh<_i168.AddToWishlistUseCase>(),
          removeWishlistUseCase: gh<_i1043.RemoveWishlistUseCase>(),
        ));
    gh.factory<_i287.ResetPasswordCubit>(() =>
        _i287.ResetPasswordCubit(useCase: gh<_i730.ResetPasswordUseCase>()));
    gh.factory<_i762.ProductsCubit>(
        () => _i762.ProductsCubit(gh<_i960.GetAllProductsUseCase>()));
    gh.factory<_i202.SubCategoriesCubit>(
        () => _i202.SubCategoriesCubit(gh<_i356.GetSubCategoriesUseCase>()));
    gh.factory<_i483.CategoryCubit>(
        () => _i483.CategoryCubit(useCase: gh<_i51.GetAllCategoriesUseCase>()));
    gh.factory<_i291.CartCubit>(() => _i291.CartCubit(
          getCartUseCase: gh<_i487.GetCartUseCase>(),
          deleteCartItemUseCase: gh<_i914.DeleteCartItemUseCase>(),
          updateCartCountUseCase: gh<_i190.UpdateCartCountUseCase>(),
        ));
    gh.factory<_i730.ProductDetailsCubit>(() => _i730.ProductDetailsCubit(
        getProductDetailsUseCase: gh<_i529.GetProductDetailsUseCase>()));
    gh.factory<_i364.LoginScreenViewModel>(() =>
        _i364.LoginScreenViewModel(loginUseCase: gh<_i806.LoginUseCase>()));
    gh.factory<_i294.ProductsBySubCategoryCubit>(() =>
        _i294.ProductsBySubCategoryCubit(
            gh<_i942.GetProductsBySubCategoryUseCase>()));
    gh.factory<_i742.VerifyResetCodeCubit>(
        () => _i742.VerifyResetCodeCubit(gh<_i919.VerifyResetCodeUseCase>()));
    return this;
  }
}
