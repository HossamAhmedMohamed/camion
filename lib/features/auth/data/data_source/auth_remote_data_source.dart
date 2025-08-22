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
      "https://api-gateway.camion-app.com/users/auth/register",
      data: {"fullName": fullName, "email": email, "phone": phoneNumber},
    );
    return response;
  }

  Future<Response> login({
    required String email,
    required String phoneNumber,
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/users/auth/login",
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
      "https://api-gateway.camion-app.com/users/auth/verify",
      data: {"email": email, "phone": phoneNumber, "code": code},
    );
    return response;
  }

  Future<Response> sendUserShippingAddress({
    required String token,
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
    required String shippingFirstName,
    required String shippingLastName,
    required String shippingAddress1,
    required String shippingAddress2,
    required String shippingCity,
    required String shippingState,
    required String shippingPostcode,
    required String shippingCountry,
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/users/shipping-address",
      data: {
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

        "shipping_option": {
          "method_id": "flat_rate",
          "method_title": "Shipping",
          "cost": "100",
        },
      },
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
