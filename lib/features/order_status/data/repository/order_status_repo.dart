import 'dart:developer';

import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/order_status/data/data_source/remote_data_source.dart';
import 'package:camion/features/order_status/data/models/order_model/order_model.dart';
import 'package:dartz/dartz.dart';

class OrderStatusRepository {
  final OrderStatusRemoteDataSource orderStatusRemoteDataSource;
  OrderStatusRepository({required this.orderStatusRemoteDataSource});

  Future<Either<ApiErrorModel, dynamic>> createOrder({
    required String token,
    required String userId,
    required List<GetCartModel> cartList,
    required int taxPrice,
    required int shippingPrice,
    required int totalOrderPrice,
    required String shippingAddress,
  }) async {
    try {
      final response = await orderStatusRemoteDataSource.createOrder(
        token: token,
        userId: userId,
        cartList: cartList,
        taxPrice: taxPrice,
        shippingPrice: shippingPrice,
        totalOrderPrice: totalOrderPrice,
        shippingAddress: shippingAddress,
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
