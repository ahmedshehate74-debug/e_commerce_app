class EndPoints {
  static const String register = '/api/v1/auth/signup';
  static const String login = '/api/v1/auth/signin';

  static const String getAllCategories = '/api/v1/categories';
  static const String getAllBrands = '/api/v1/brands';
  static const String getAllProducts = '/api/v1/products';
  static const String getSpecificProduct = '/api/v1/products';

  static const String addToCart = '/api/v1/cart';
  static const String getCart = '/api/v1/cart';
  static const String updateCart = '/api/v1/cart';
//  static const String createOrder =
//       "/orders";
  // Wishlist
  static const String wishlist = '/api/v1/wishlist';

  static const String forgetPassword = '/api/v1/auth/forgotPasswords';
  static const String verifyResetCode = '/api/v1/auth/verifyResetCode';
  static const String resetPassword = '/api/v1/auth/resetPassword';
}