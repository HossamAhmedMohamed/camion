import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class CartRemoteDataSource {
  final ApiConsumer apiConsumer;

  CartRemoteDataSource({required this.apiConsumer});

  Future<Response> addToCart({
    required String token,
    required String productId,
    required int quantity,
    required List<dynamic> variations,
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/cart/add",
      headers: {"Authorization": "Bearer $token"},
      data: {
        "productId": productId,
        "quantity": quantity,
        "variation": variations,
      },
    );
    return response;
  }

  Future<Response> getCart({required String token}) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/cart/get",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> updateCart({
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final response = await apiConsumer.patch(
      "https://api-gateway.camion-app.com/cart/update",
      headers: {"Authorization": "Bearer $token"},
      data: {"productId": productId, "quantity": quantity},
    );
    return response;
  }

  Future<Response> deleteFromCart({
    required String token,
    required String productId,
  }) async {
    final response = await apiConsumer.delete(
      "https://api-gateway.camion-app.com/cart/remove",
      headers: {"Authorization": "Bearer $token"},
      data: {"productId": productId},
    );
    return response;
  }
}
