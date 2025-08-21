import 'dart:developer';

import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:camion/features/auth/data/models/verify_model/verify_model.dart';
import 'package:camion/features/auth/data/models/register_model.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepository({required this.authRemoteDataSource});

  Future<Either<ApiErrorModel, RegisterModel>> register({
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final response = await authRemoteDataSource.register(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
      );
      return Right(RegisterModel.fromJson(response.data));
    } catch (e) {
      log("repoooo${e.toString()}");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> login({
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final response = await authRemoteDataSource.login(
        email: email,
        phoneNumber: phoneNumber,
      );
      return Right(response.data["msg"]);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, VerifyModel>> verify({
    required String email,
    required String phoneNumber,
    required String code,
  }) async {
    try {
      final response = await authRemoteDataSource.verify(
        email: email,
        phoneNumber: phoneNumber,
        code: code,
      );
      return Right(VerifyModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> sendUserShippingAddress({
    required String token,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address1,
    required String address2,
    required String city,
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
    try {
      final response = await authRemoteDataSource.sendUserShippingAddress(
        token: token,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        address1: address1,
        address2: address2,
        city: city,
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
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
