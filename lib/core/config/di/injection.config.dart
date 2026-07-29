// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supermarket/core/config/di/injectable_module.dart' as _i906;
import 'package:supermarket/core/data/network/auth_interceptor.dart' as _i402;
import 'package:supermarket/core/services/connection_checker.dart' as _i369;
import 'package:supermarket/features/Auth/data/datasources/auth_remote_datasource.dart'
    as _i636;
import 'package:supermarket/features/Auth/data/repositories/auth_repository_impl.dart'
    as _i799;
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart'
    as _i900;
import 'package:supermarket/features/Auth/domain/use_cases/check_app_state_use_case.dart'
    as _i814;
import 'package:supermarket/features/Auth/domain/use_cases/google_auth_use_case.dart'
    as _i398;
import 'package:supermarket/features/Auth/domain/use_cases/login_use_case.dart'
    as _i468;
import 'package:supermarket/features/Auth/domain/use_cases/signup_use_case.dart'
    as _i815;
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart'
    as _i400;
import 'package:supermarket/features/Cart/data/data_sources/remote/cart_remote_data_source.dart'
    as _i652;
import 'package:supermarket/features/Cart/data/repositories/cart_repository_impl.dart'
    as _i927;
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart'
    as _i671;
import 'package:supermarket/features/Cart/domain/usecases/add_item_use_case.dart'
    as _i518;
import 'package:supermarket/features/Cart/domain/usecases/get_cart_use_case.dart'
    as _i660;
import 'package:supermarket/features/Cart/domain/usecases/remove_item_use_case.dart'
    as _i818;
import 'package:supermarket/features/Cart/domain/usecases/update_item_use_case.dart'
    as _i1034;
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart'
    as _i772;
import 'package:supermarket/features/Categories/data/data_sources/remote/categories_remote_data_source.dart'
    as _i513;
import 'package:supermarket/features/Categories/data/repositories/category_repository_impl.dart'
    as _i502;
import 'package:supermarket/features/Categories/domain/repositories/category_repository.dart'
    as _i741;
import 'package:supermarket/features/Categories/domain/use_cases/get_categories_use_case.dart'
    as _i347;
import 'package:supermarket/features/Categories/presentations/blocs/categories_cubit/categories_cubit.dart'
    as _i552;
import 'package:supermarket/features/Home/data/data_sources/remote/home_remote_data_source.dart'
    as _i1037;
import 'package:supermarket/features/Home/data/repositories/home_repository_impl.dart'
    as _i1001;
import 'package:supermarket/features/Home/domain/repositories/home_repository.dart'
    as _i84;
import 'package:supermarket/features/Home/domain/use_cases/get_home_data_use_case.dart'
    as _i711;
import 'package:supermarket/features/Home/presentation/blocs/home/home_cubit.dart'
    as _i265;
import 'package:supermarket/features/Home/presentation/blocs/search/home_search_cubit.dart'
    as _i115;
import 'package:supermarket/features/Product/data/data_sources/remote/product_remote_data_source.dart'
    as _i584;
import 'package:supermarket/features/Product/data/repositories/product_repository_impl.dart'
    as _i623;
import 'package:supermarket/features/Product/domain/repositories/product_repository.dart'
    as _i941;
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart'
    as _i80;
import 'package:supermarket/features/Product/presentation/blocs/products_cubit/products_cubit.dart'
    as _i814;
import 'package:supermarket/features/User/data/datasources/user_local_datasource.dart'
    as _i744;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => injectableModule.secureStorage,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioDevInstance);
    gh.lazySingleton<_i116.GoogleSignIn>(() => injectableModule.googleSignIIn);
    gh.lazySingleton<_i895.Connectivity>(() => injectableModule.connectivity);
    gh.lazySingleton<_i513.CategoriesRemoteDataSource>(
      () => _i513.CategoriesRemoteDataSourceImpl.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i652.CartRemoteDataSource>(
      () => _i652.CartRemoteDataSourceImpl.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i584.ProductRemoteDataSource>(
      () => _i584.ProductRemoteDataSourceImpl.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i671.CartRepository>(
      () => _i927.CartRepositoryImpl(gh<_i652.CartRemoteDataSource>()),
    );
    gh.lazySingleton<_i744.UserLocalDataSource>(
      () => _i744.UserLocalDataSourceImpl(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i518.AddItemUseCase>(
      () => _i518.AddItemUseCase(gh<_i671.CartRepository>()),
    );
    gh.lazySingleton<_i741.CategoryRepository>(
      () =>
          _i502.CategoryRepositoryImpl(gh<_i513.CategoriesRemoteDataSource>()),
    );
    gh.lazySingleton<_i1037.HomeRemoteDataSource>(
      () => _i1037.HomeRemoteDataSourceImpl.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i369.ConnectionChecker>(
      () => _i369.ConnectionCheckerConnectivity(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i636.AuthRemoteDataSource>(
      () => _i636.AuthRemoteDataSourceImpl(
        dioClient: gh<_i361.Dio>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i941.ProductRepository>(
      () => _i623.ProductRepositoryImpl(gh<_i584.ProductRemoteDataSource>()),
    );
    gh.lazySingleton<_i347.GetCategoriesUseCase>(
      () => _i347.GetCategoriesUseCase(gh<_i741.CategoryRepository>()),
    );
    gh.lazySingleton<_i402.AuthInterceptor>(
      () => _i402.AuthInterceptor(gh<_i744.UserLocalDataSource>()),
    );
    gh.lazySingleton<_i818.RemoveItemUseCase>(
      () => _i818.RemoveItemUseCase(gh<_i671.CartRepository>()),
    );
    gh.lazySingleton<_i660.GetCartUseCase>(
      () => _i660.GetCartUseCase(gh<_i671.CartRepository>()),
    );
    gh.lazySingleton<_i1034.UpdateItemUseCase>(
      () => _i1034.UpdateItemUseCase(gh<_i671.CartRepository>()),
    );
    gh.factory<_i552.CategoriesCubit>(
      () => _i552.CategoriesCubit(gh<_i347.GetCategoriesUseCase>()),
    );
    gh.lazySingleton<_i84.HomeRepository>(
      () => _i1001.HomeRepositoryImpl(gh<_i1037.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i900.AuthRepository>(
      () => _i799.AuthRepositoryImpl(
        userLocalDataSource: gh<_i744.UserLocalDataSource>(),
        authRemoteDataSource: gh<_i636.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i80.GetProductsUseCase>(
      () => _i80.GetProductsUseCase(gh<_i941.ProductRepository>()),
    );
    gh.factory<_i772.CartCubit>(
      () => _i772.CartCubit(
        gh<_i660.GetCartUseCase>(),
        gh<_i518.AddItemUseCase>(),
        gh<_i1034.UpdateItemUseCase>(),
        gh<_i818.RemoveItemUseCase>(),
      ),
    );
    gh.factory<_i814.ProductsCubit>(
      () => _i814.ProductsCubit(gh<_i80.GetProductsUseCase>()),
    );
    gh.lazySingleton<_i711.GetHomeDataUseCase>(
      () => _i711.GetHomeDataUseCase(gh<_i84.HomeRepository>()),
    );
    gh.factory<_i265.HomeCubit>(
      () => _i265.HomeCubit(gh<_i711.GetHomeDataUseCase>()),
    );
    gh.factory<_i115.HomeSearchCubit>(
      () => _i115.HomeSearchCubit(gh<_i80.GetProductsUseCase>()),
    );
    gh.lazySingleton<_i815.SignupUseCase>(
      () => _i815.SignupUseCase(authRepository: gh<_i900.AuthRepository>()),
    );
    gh.lazySingleton<_i468.LoginUseCase>(
      () => _i468.LoginUseCase(authRepository: gh<_i900.AuthRepository>()),
    );
    gh.lazySingleton<_i398.GoogleAuthUseCase>(
      () => _i398.GoogleAuthUseCase(authRepository: gh<_i900.AuthRepository>()),
    );
    gh.lazySingleton<_i814.CheckAppStateUseCase>(
      () => _i814.CheckAppStateUseCase(
        authRepository: gh<_i900.AuthRepository>(),
      ),
    );
    gh.factory<_i400.AuthBloc>(
      () => _i400.AuthBloc(
        gh<_i468.LoginUseCase>(),
        gh<_i815.SignupUseCase>(),
        gh<_i398.GoogleAuthUseCase>(),
        gh<_i814.CheckAppStateUseCase>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i906.InjectableModule {}
