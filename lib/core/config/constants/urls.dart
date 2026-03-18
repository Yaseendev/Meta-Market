import 'package:supermarket/core/config/environment/env_config.dart';

class Urls {
  static final String DOMAIN =
      EnvironmentConfig.baseUrl; //localhost //TODO: move it to .env
  static final String BASE_API = DOMAIN + '/api/v1';
  static const String AUTH_PATH = '/auth';
  static const String PRODUCT_PATH = '/products';
  static const String CART_PATH = '/cart';
  static const String WISHLIST_PATH = '/wishlist';
  static const String USER_PATH = '/user';
  static const String GET_CATEGORIES = '/categories';
  static const String ORDERS_PATH = '/orders';
  static const String COUPON_PATH = '/coupon';
  static const String TOKEN_CHECK_API = '$AUTH_PATH/token-check';
  static const String LOG_IN_API = '$AUTH_PATH/sign-in';
  static const String REGISTER = '$AUTH_PATH/register';
  static const String GOOGLE_AUTH = '$AUTH_PATH/google';
}