import 'dart:developer';
import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/order_status/data/data_source/remote_data_source.dart';
import 'package:camion/features/order_status/data/models/order_model/order_model.dart';
import 'package:dartz/dartz.dart';

class OrderStatusRepository {
  final OrderStatusRemoteDataSource orderStatusRemoteDataSource;
  OrderStatusRepository({required this.orderStatusRemoteDataSource});

  Future<Either<ApiErrorModel, dynamic>> createOrder({
    required String token,
    // required String userId,

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
    required String paymentMethodId,
  }) async {
    try {
      final response = await orderStatusRemoteDataSource.createOrder(
        token: token,
        // userId: userId,

        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        postcode: postcode,
        country: country,
        shippingFirstName: shippingFirstName,
        shippingLastName: shippingLastName,
        shippingAddress1: shippingAddress1,
        shippingAddress2: shippingAddress2,
        shippingCity: shippingCity,
        shippingState: shippingState,
        shippingPostcode: shippingPostcode,
        shippingCountry: shippingCountry,
        paymentMethod: paymentMethod,
        paymentMethodId: paymentMethodId,
      );

      return right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<OrderModel>>> getOrders({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await orderStatusRemoteDataSource.getOrders(
        token: token,
        userId: userId,
      );

      final orders = (response.data as List).map((order) {
        log(order.toString());
        return OrderModel.fromJson(order);
      }).toList();
      return right(orders);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }
}
