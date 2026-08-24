import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/core/routes_manager/routes.dart';
import 'package:flutter_e_commerce_c11_online/di/di.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/reset_password/reset_password_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/auth/presentation/screens/verify_reset_code.dart/verify_reset_code_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/cart/screens/cart_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/model/payment_args.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/presentation/screens/payment_method_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/check_out/presentation/screens/success_screen.dart';
import 'package:flutter_e_commerce_c11_online/features/product_details/cubit/product_details_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/product_details/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flutter_e_commerce_c11_online/features/splash/splash_screen.dart';
import '../../features/auth/presentation/screens/sign_in/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/product_details/presentation/screen/product_details.dart';
import '../../features/products_screen/presentation/screens/products_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
     case Routes.cartRoute:
  return MaterialPageRoute(
    builder: (_) => const CartScreen(),
  );
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case Routes.productsScreenRoute:

  final String subCategoryId =
      settings.arguments as String;

  return MaterialPageRoute(
    builder: (_) => ProductsScreen(
      subCategoryId: subCategoryId,
    ),
  );

     case Routes.productDetails:

  final String productId = settings.arguments as String;

  return MaterialPageRoute(
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductDetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<AddToCartCubit>(),
        ),
      ],
      child: ProductDetails(
        productId: productId,
      ),
    ),
  );
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) =>  SignInScreen());

      case Routes.splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) =>  SignUpScreen());

        case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) =>  ForgetPasswordScreen());
          case Routes.verifyResetCode:
        return MaterialPageRoute(builder: (_) =>   VerifyResetCodeScreen(
          
        ));
  case Routes.paymentMethod:
  final args = settings.arguments as PaymentArgs;

  return MaterialPageRoute(
    builder: (_) => PaymentMethodScreen(
      totalPrice: args.totalPrice,
      cartId: args.cartId,
    ),
  );  
 
        case Routes.resetPasswordRoute:
  return MaterialPageRoute(
    builder: (_) => ResetPasswordScreen(),
  );
 case Routes.successScreen:
  final args = settings.arguments as Map<String, dynamic>;

  return MaterialPageRoute(
    builder: (_) => SuccessScreen(
      paymentId: args["paymentId"] as String,
      paymentMethod: args["paymentMethod"] as String,
      status: args["status"] as String,
      totalPrice: args["totalPrice"] as double,
    ),
  );
      default:
        return unDefinedRoute();
    }
  }
  

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
