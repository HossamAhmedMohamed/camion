import 'package:camion/core/api/api_consumer.dart';

import 'package:dio/dio.dart';

class OrderStatusRemoteDataSource {
  final ApiConsumer apiConsumer;
  OrderStatusRemoteDataSource({required this.apiConsumer});

  // Future<Response> calculateShippingAddress({
  //   required List<GetCartModel> items,
  //   required String firstName,
  //   required String lastName,
  //   required String address1,
  //   required String city,
  //   required String postcode,
  //   required String country,
  // }) async {
  //   List<Map<String, dynamic>> itemsData = items
  //       .map(
  //         (item) => {
  //           'id': item.id,
  //           'quantity': item.quantity,
  //           'variation': item.variation,
  //         },
  //       )
  //       .toList();
  //   final response = await apiConsumer.post(
  //     "https://buckydrop.camion-app.com/api/shipping/calculate",
  //     data: {
  //       "items": itemsData,
  //       "shippingAddress": {
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "address_1": address1,
  //         "city": city,
  //         "postcode": postcode,
  //         "country": country,
  //       },
  //     },
  //   );
  //   return response;
  // }

  Future<Response> createOrder({required String token}) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/checkout/complete",
      data: {"payment_method": "skipcash", "payment_data": []},
      headers: {"Authorization": "Bearer $token"},
    );

    return response;
  }

  Future<Response> getOrders({
    required String token,
    required String userId,
  }) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/checkout/user/$userId",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> getOrderStatus({
    required String token,
    required String status,
  }) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/checkout/status/$status",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> getOrderTracking({
    required String token,
    required String orderId,
  }) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/tracking/order/$orderId",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
