import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class NotificationRemoteDataSource {
  final ApiConsumer apiConsumer;
  NotificationRemoteDataSource({required this.apiConsumer});


  Future<Response> getNotifications({required String token}) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/users/notifications/me",
      headers: {
        "Authorization":
            "Bearer $token",
      }
    );
    return response;
  }
}