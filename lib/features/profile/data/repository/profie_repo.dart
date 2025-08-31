import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/profile/data/data_source/remote_data_source.dart';
import 'package:camion/features/profile/data/models/get_user_model/user_model.dart';
import 'package:camion/features/profile/data/models/transaction_model/transactions.dart';
import 'package:dartz/dartz.dart';

class ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepository({required this.profileRemoteDataSource});

  Future<Either<ApiErrorModel, GetUserModel>> getUserById({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await profileRemoteDataSource.getUserById(
        token: token,
        userId: userId,
      );
      return Right(GetUserModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, GetUserModel>> updateUser({
    required String token,
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await profileRemoteDataSource.updateUser(
        token: token,
        userId: userId,
        data: data,
      );
      return Right(GetUserModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> getWalletBalance({
    required String token,
  }) async {
    try {
      final response = await profileRemoteDataSource.getWalletBalance(
        token: token,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<Transactions>>> getAllTransactions({
    required String token,
  }) async {
    try {
      final response = await profileRemoteDataSource.getAllTransactions(
        token: token,
      );
      final transations = (response.data as List)
          .map((transaction) => Transactions.fromJson(transaction))
          .toList();
      return Right(transations);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> deleteAccount({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await profileRemoteDataSource.deleteAccount(
        token: token,
        userId: userId,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
