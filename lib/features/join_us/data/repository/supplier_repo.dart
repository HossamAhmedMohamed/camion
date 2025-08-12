import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/join_us/data/data_source/remote_data_source.dart';
import 'package:camion/features/join_us/data/models/affiliate_model/affiliate_model.dart';
import 'package:dartz/dartz.dart';

class SupplierRepository {
  final SupplierRemoteDataSource supplierRemoteDataSource;
  SupplierRepository({required this.supplierRemoteDataSource});

  Future<Either<ApiErrorModel, AffiliateModel>> signSupplier({
    required String token,
    required String name,
    required String nationality,
    required String gender,
    required String bio,
   
  }) async {
    try {
      final response = await supplierRemoteDataSource.signSupplier(
        token: token,
        name: name,
        nationality: nationality,
        gender: gender,
        bio: bio,
         
      );
      return Right(AffiliateModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> getAffiliatePendings({required String token}) async {
    try {
      final response = await supplierRemoteDataSource.getAffiliatePendings(token: token);
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> createCoupon({
    required String token,
    required String code,
 
    required String discountPercentage,
  }) async {
    try {
      final response = await supplierRemoteDataSource.createCoupon(
        token: token,
        code: code,
       
        discountPercentage: discountPercentage,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> getCouponCodeByAffiliateId({
    required String token,
  }) async {
    try {
      final response = await supplierRemoteDataSource.getCouponCodeByAffiliateId(token: token);
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
