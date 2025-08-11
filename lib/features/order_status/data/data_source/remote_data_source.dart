import 'package:camion/core/api/api_consumer.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:dio/dio.dart';

class OrderStatusRemoteDataSource {
  final ApiConsumer apiConsumer;
  OrderStatusRemoteDataSource({required this.apiConsumer});

  Future<Response> createOrder({
    required String token,
    required String userId,
    required List<GetCartModel> cartList,
    required String taxPrice,
    required String shippingPrice,
    required String totalOrderPrice,
    required String shippingAddress,
  }) async {
    final response = await apiConsumer.post(
      "http://api-gateway.camion-app.com/orders/create",
      data: {
        "cartItems": cartList,
        "taxPrice": taxPrice,
        "shippingPrice": shippingPrice,
        "totalOrderPrice": totalOrderPrice,
        "shippingAddress": shippingAddress,
      },
      headers: {"Authorization": "Bearer $token"},
    );

    return response;
  }

  Future<Response> getOrders({
    required String token,
    required String userId,
  }) async {
    final response = await apiConsumer.get(
      "http://api-gateway.camion-app.com/orders/user/$userId",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
