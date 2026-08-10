import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Address/data/models/address/address_model.dart';
import 'package:supermarket/features/Address/data/models/address_request/address_request_model.dart';

part 'address_remote_data_source.g.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> createAddress(AddressRequestModel request);
  Future<AddressModel> updateAddress(int id, AddressRequestModel request);
  Future<dynamic> deleteAddress(int id);
}

@LazySingleton(as: AddressRemoteDataSource)
@RestApi()
abstract class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  @factoryMethod
  factory AddressRemoteDataSourceImpl(Dio dio) =>
      _AddressRemoteDataSourceImpl(dio);

  @override
  @GET(Urls.ADDRESS_PATH)
  Future<List<AddressModel>> getAddresses();

  @override
  @POST(Urls.ADDRESS_PATH)
  Future<AddressModel> createAddress(@Body() AddressRequestModel request);

  @override
  @PUT('${Urls.ADDRESS_PATH}/{addressId}')
  Future<AddressModel> updateAddress(
    @Path('addressId') int id, @Body() AddressRequestModel request);

  @override
  @DELETE('${Urls.ADDRESS_PATH}/{addressId}')
  Future<dynamic> deleteAddress(@Path('addressId') int id);
}
