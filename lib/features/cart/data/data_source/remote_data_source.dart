import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class CartRemoteDataSource {
  final ApiConsumer apiConsumer;

  CartRemoteDataSource({required this.apiConsumer});

  Future<Response> addToCart({
    required String token,

    required String productId,
    required String title,
    required String price,
    required String image,
    required int quantity,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/cart/add",
      headers: {"Authorization": "Bearer $token"},
      data: {
        "productId": productId,
        "title": title,
        "price": price,
        "image": image,
        "quantity": quantity,
      },
    );
    return response;
  }

  Future<Response> getCart({required String token}) async {
    final response = await apiConsumer.get(
      "http://api-gateway.camion-app.com/cart/get",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
