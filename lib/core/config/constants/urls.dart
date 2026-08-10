import 'package:supermarket/core/config/environment/env_config.dart';

class Urls {
  static final String DOMAIN = EnvironmentConfig.baseUrl;
  static final String BASE_API = DOMAIN + '/api/v1';
  static const String AUTH_PATH = '/auth';
  static const String PRODUCT_PATH = '/products';
  static const String CART_PATH = '/cart';
  static const String WISHLIST_PATH = '/wishlist';
  static const String USER_PATH = '/user';
  static const String GET_CATEGORIES = '/categories';
  static const String ORDERS_PATH = '/orders';
  static const String COUPON_PATH = '/coupon';
  static const String PROFILE_PATH = '/profile';
  static const String ADDRESS_PATH = '/addresses';
  static const String TOKEN_CHECK_API = '$AUTH_PATH/token-check';
  static const String LOG_IN_API = '$AUTH_PATH/sign-in';
  static const String REGISTER = '$AUTH_PATH/register';
  static const String GOOGLE_AUTH = '$AUTH_PATH/google';
  static const String SEARCH_PRODUCTS = '$PRODUCT_PATH/search';
  static const String ADD_ITEM = '$CART_PATH/add';
  static const String UPDATE_ITEM = '$CART_PATH/update';
  static const String REMOVE_ITEM = '$CART_PATH/remove';
  static const String HOME = '/home';

  static String getStaticMapUrl({
    required double latitude,
    required double longitude,
  }) =>
      'https://api.mapbox.com/styles/v1/mapbox/streets-v12/static/'
      'pin-s+ff0000($longitude,$latitude)/'
      '$longitude,$latitude,16/600x400'
      '?access_token=${EnvironmentConfig.mapBoxAccessToken}';
}
