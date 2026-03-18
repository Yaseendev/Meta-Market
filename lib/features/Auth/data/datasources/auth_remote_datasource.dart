import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> checkToken(String token);
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> signup(
      String email, String password, NameModel name, String phoneNumber);
  Future<GoogleSignInAccount?> signInGoogle();
  Future<Map<String, dynamic>> authWithGoogle(
      String googleAccessToken, NameModel name);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dioClient;
  final GoogleSignIn googleSignIn;

  const AuthRemoteDataSourceImpl({
    required this.dioClient,
    required this.googleSignIn,
  });

  @override
  //TODO: Refactor
  Future<Map<String, dynamic>> checkToken(String token) async {
    final Response response = await dioClient.post(
      Urls.TOKEN_CHECK_API,
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final Response response = await dioClient.post(
      Urls.LOG_IN_API,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> signup(
      String email, String password, NameModel name, String phoneNumber) async {
    final Response response = await dioClient.post(
      Urls.REGISTER,
      data: {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        // 'name': name.toMap(),
      },
    );
    return response.data;
  }

  @override
  Future<GoogleSignInAccount?> signInGoogle() async {
    return await googleSignIn.signIn();
  }

  @override
  Future<Map<String, dynamic>> authWithGoogle(
      String googleAccessToken, NameModel name) async {
    final Response response = await dioClient.post(
      Urls.GOOGLE_AUTH,
      data: {
        'accessToken': googleAccessToken,
        // 'name': name.toMap(),
      },
    );
    return response.data;
  }
}
