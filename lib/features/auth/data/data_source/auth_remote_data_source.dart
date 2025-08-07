import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final ApiConsumer apiConsumer;
  AuthRemoteDataSource({required this.apiConsumer});

  Future<Response> register({
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/users/auth/register",
      data: {"fullName": fullName, "email": email, "phone": phoneNumber},
    );
    return response;
  }

  Future<Response> login({
    required String email,
    required String phoneNumber,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/users/auth/login",
      data: {"email": email, "phone": phoneNumber},
    );
    return response;
  }

  Future<Response> verify({
    required String email,
    required String phoneNumber,
    required String code,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/users/auth/verify",
      data: {"email": email, "phone": phoneNumber, "code": code},
    );
    return response;
  }
}
