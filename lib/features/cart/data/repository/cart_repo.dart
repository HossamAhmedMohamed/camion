import 'dart:developer';

import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/cart/data/data_source/remote_data_source.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:dartz/dartz.dart';

class CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  CartRepository({required this.cartRemoteDataSource});

  Future<Either<ApiErrorModel, dynamic>> addToCart({
    required String token,
    required String userId,
    required String productId,
    required String title,
    required int price,
    required String image,
    required int quantity,
  }) async {
    try {
      final response = await cartRemoteDataSource.addToCart(
        token: token,
        userId: userId,
        productId: productId,
        title: title,
        price: price,
        image: image,
        quantity: quantity,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<GetCartModel>>> getCart({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await cartRemoteDataSource.getCart(
        token: token,
        userId: userId,
      );
      final List<GetCartModel> cart = (response.data as List)
          .map((cart) => GetCartModel.fromJson(cart))
          .toList();
          log(cart.toString());
      return Right(cart);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }
}
