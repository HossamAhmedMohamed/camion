import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;
  ProfileRemoteDataSource({required this.apiConsumer});

  Future<Response> getUserById({
    required String token,
    required String userId,
  }) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/users/$userId",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }


  Future<Response> updateUser({
    required String token,
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiConsumer.patch(
      "https://api-gateway.camion-app.com/users/$userId",
      headers: {"Authorization": "Bearer $token"},
      data: data,
    );
    return response;
  }
  Future<Response> getWalletBalance({
    required String token,
  }) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/affiliates/wallet",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }


  Future<Response> getAllTransactions({
    required String token,
  }) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/affiliates/wallet/transactions",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
