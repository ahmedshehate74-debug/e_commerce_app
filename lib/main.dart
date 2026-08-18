import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/network/api_keys.dart';
import 'package:flutter_e_commerce_c11_online/features/cart/cubit/cart_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/cubit/checkout_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/categories/cubit/sub_categories_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/product_details/cubit/product_details_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_e_commerce_c11_online/core/my_bloc_observer.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';

import 'package:flutter_e_commerce_c11_online/core/routes_manager/route_generator.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';

import 'package:flutter_e_commerce_c11_online/di/di.dart';

import 'package:flutter_e_commerce_c11_online/features/main_layout/cubit/categories_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/brand_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/products_cubit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiKeys.publishableKey;

  await Stripe.instance.applySettings();

  configureDependencies();

  await SharedPreferenceUtils.init();

  final token = SharedPreferenceUtils.getData(key: "token");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CategoryCubit>()..getCategories(),
        ),
        BlocProvider(
          create: (_) => getIt<BrandCubit>()..getBrands(),
        ),
        BlocProvider(
          create: (_) => getIt<ProductsCubit>()..getProducts(),
        ),
        BlocProvider(
          create: (_) => getIt<ProductDetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<CartCubit>()..getCart(),
        ),
        BlocProvider(
          create: (_) => getIt<WishlistCubit>()..getWishlist(),
        ),
        BlocProvider(
          create: (_) => getIt<SubCategoriesCubit>(),
        ),
            // أضف ده
    BlocProvider(
      create: (_) => getIt<CheckoutCubit>(),
    ),
      ],
      child: MyApp(
        route: token == null ? Routes.signInRoute : Routes.mainRoute,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String route;

  const MyApp({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: route,
          onGenerateRoute: RouteGenerator.getRoute,
        );
      },
    );
  }
}
