import 'dart:developer';
import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/cart/data/data_source/remote_data_source.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/models/get_user_address_model.dart';
import 'package:dartz/dartz.dart';

class CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  CartRepository({required this.cartRemoteDataSource});

  Future<Either<ApiErrorModel, dynamic>> addToCart({
    required String token,
    required String productId,
    required int quantity,
    required List<dynamic> variations,
  }) async {
    try {
      final response = await cartRemoteDataSource.addToCart(
        token: token,
        productId: productId,
        quantity: quantity,
        variations: variations,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<GetCartModel>>> getCart({
    required String token,
  }) async {
    try {
      final response = await cartRemoteDataSource.getCart(token: token);
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

  Future<Either<ApiErrorModel, GetCartModel>> updateCart({
    required String token,
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await cartRemoteDataSource.updateCart(
        token: token,
        productId: productId,
        quantity: quantity,
      );

      return Right(GetCartModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, GetCartModel>> deleteFromCart({
    required String token,
    required String productId,
  }) async {
    try {
      final response = await cartRemoteDataSource.deleteFromCart(
        token: token,
        productId: productId,
      );
      return Right(GetCartModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> applyCoupon({
    required String token,
    required String code,
  }) async {
    try {
      final response = await cartRemoteDataSource.applyCoupon(
        token: token,
        code: code,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, GetUserAddressModel>> getUserAddress({
    required String token,
  }) async {
    try {
      final response = await cartRemoteDataSource.getUserAddress(token: token);
      return Right(GetUserAddressModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
