import 'package:camion/core/api/api_consumer.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/order_status/data/models/shipping_method_model.dart';

import 'package:dio/dio.dart';

class OrderStatusRemoteDataSource {
  final ApiConsumer apiConsumer;
  OrderStatusRemoteDataSource({required this.apiConsumer});

  Future<Response> calculateShippingAddress({
    required List<GetCartModel> items,
    required String firstName,
    required String lastName,
    required String address1,
    required String city,
    required String postcode,
    required String country,
  }) async {
    List<Map<String, dynamic>> itemsData = items
        .map(
          (item) => {
            'id': item.id,
            'quantity': item.quantity,
            'variation': item.variation,
          },
        )
        .toList();
    final response = await apiConsumer.post(
      "https://buckydrop.camion-app.com/api/shipping/calculate",
      data: {
        "items": itemsData,
        "shippingAddress": {
          "first_name": firstName,
          "last_name": lastName,
          "address_1": address1,
          "city": city,
          "postcode": postcode,
          "country": country,
        },
      },
    );
    return response;
  }

  Future<Response> createOrder({
    required String token,

    // required String userId,
    required ShippingMethodModel shippingMethodModel,
    // Customer data parameters
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String postcode,
    required String country,
    // Shipping address parameters
    required String shippingFirstName,
    required String shippingLastName,
    required String shippingAddress1,
    required String shippingAddress2,
    required String shippingCity,
    required String shippingState,
    required String shippingPostcode,
    required String shippingCountry,
    // Payment parameters
    required String paymentMethod,
    // required String paymentMethodId,
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/checkout/complete",
      data: {
        "customer_data": {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone": phone,
          "address_1": address1,
          "address_2": address2,
          "city": city,
          "state": state,
          "postcode": postcode,
          "country": country,
          "shipping_address": {
            "first_name": shippingFirstName,
            "last_name": shippingLastName,
            "address_1": shippingAddress1,
            "address_2": shippingAddress2,
            "city": shippingCity,
            "state": shippingState,
            "postcode": shippingPostcode,
            "country": shippingCountry,
          },
          "shipping_option": shippingMethodModel.toJson(),
        },
        "payment_method": paymentMethod,
        "payment_data": [
          // {"key": "payment_method_id", "value": paymentMethodId},
        ],
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
      "https://api-gateway.camion-app.com/checkout/user/$userId",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
