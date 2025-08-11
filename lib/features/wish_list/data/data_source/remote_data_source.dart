import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class WishListRemoteDataSource {
  final ApiConsumer apiConsumer;

  WishListRemoteDataSource({required this.apiConsumer});

  Future<Response> addToWishList({
    required String token,

    required String productId,
    required String title,
    required String price,
    required String image,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/wishlist/add",
      headers: {"Authorization": "Bearer $token"},
      data: {
        "productId": productId,
        "productName": title,
        "productImage": image,
        "price": price,
      },
    );
    return response;
  }

  Future<Response> getWishList({required String token}) async {
    final response = await apiConsumer.get(
      "http://api-gateway.camion-app.com/wishlist/get",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> removeFromWishList({
    required String token,
    required String productId,
  }) async {
    final response = await apiConsumer.delete(
      "http://api-gateway.camion-app.com/wishlist/remove",
      headers: {"Authorization": "Bearer $token"},
      data: {"productId": productId},
    );
    return response;
  }
}
