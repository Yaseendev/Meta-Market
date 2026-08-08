import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/User/data/models/app_user_model.dart';

part 'user_remote_datasource.g.dart';

abstract class UserRemoteDataSource {
  Future<AppUserModel> getUser();
  Future<AppUserModel> editUserProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });
  Future<dynamic> deleteUser();
}

@LazySingleton(as: UserRemoteDataSource)
@RestApi()
abstract class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @factoryMethod
  factory UserRemoteDataSourceImpl(Dio dio) {
    return _UserRemoteDataSourceImpl(dio);
  }

  @override
  @GET(Urls.PROFILE_PATH)
  Future<AppUserModel> getUser();

  @override
  @PUT(Urls.PROFILE_PATH)
  Future<AppUserModel> editUserProfile({
    @Field() required String email,
    @Field() required String firstName,
    @Field() required String lastName,
    @Field('phone_number') required String phoneNumber,
  });

  @override
  @DELETE(Urls.PROFILE_PATH)
  Future<dynamic> deleteUser();
}
