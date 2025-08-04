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
}
