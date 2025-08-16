import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/profile/data/data_source/remote_data_source.dart';
import 'package:camion/features/profile/data/models/get_user_model/user_model.dart';
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
}
