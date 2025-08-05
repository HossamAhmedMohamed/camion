import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class WishListRemoteDataSource {
  final ApiConsumer apiConsumer;

  WishListRemoteDataSource({required this.apiConsumer});

  Future<Response> addToWishList({
    required String token,
    required String userId,
    required String productId,
    required String title,
    required int price,
    required String image,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/wishlist/add",
      headers: {"Authorization": "Bearer $token"},
      data: {
        "userId": userId,
        "productId": productId,
        "productName": title,
        "productImage": image,
        "price": price,
      },
    );
    return response;
  }

  Future<Response> getWishList({
    required String token,
    required String userId,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/wishlist/get",
      headers: {"Authorization": "Bearer $token"},
      data: {"userId": userId},
    );
    return response;
  }
}
