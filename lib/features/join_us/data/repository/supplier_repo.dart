import 'dart:developer';

import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/join_us/data/data_source/remote_data_source.dart';
import 'package:camion/features/join_us/data/models/affiliate_model/affiliate_model.dart';
import 'package:camion/features/join_us/data/models/affiliate_status/affiliate_status_model.dart';
import 'package:camion/features/join_us/data/models/coupons_model/get_coupons_model.dart';
import 'package:dartz/dartz.dart';

class AffiliateRepository {
  final AffiliateRemoteDataSource supplierRemoteDataSource;
  AffiliateRepository({required this.supplierRemoteDataSource});

  Future<Either<ApiErrorModel, AffiliateModel>> signAffiliate({
    required String token,
    required String name,
    required String nationality,
    required String gender,
    required String bio,
  }) async {
    try {
      final response = await supplierRemoteDataSource.signAffiliate(
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

  Future<Either<ApiErrorModel, AffiliateStatus>> getAffiliateStatus({
    required String token,
  }) async {
    try {
      final response = await supplierRemoteDataSource.getAffiliateStatus(
        token: token,
      );
      return Right(AffiliateStatus.fromJson(response.data));
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> createCoupon({
    required String token,
    required String code,

    required num discountPercentage,
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

  Future<Either<ApiErrorModel, List<GetCouponsModel>>>
  getCouponCodeByAffiliateId({required String token}) async {
    try {
      final response = await supplierRemoteDataSource
          .getCouponCodeByAffiliateId(token: token);
      final List<GetCouponsModel> coupons = (response.data as List)
          .map((coupon) => GetCouponsModel.fromJson(coupon))
          .toList();
      return Right(coupons);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
