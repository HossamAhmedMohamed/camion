import 'package:camion/core/api/api_consumer.dart';
import 'package:dio/dio.dart';

class AffiliateRemoteDataSource {
  final ApiConsumer apiConsumer;
  AffiliateRemoteDataSource({required this.apiConsumer});

  Future<Response> signAffiliate({
    required String token,
    required String name,
    required String nationality,
    required String gender,
    required String bio,
 
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/affiliates/request",
      headers: {"Authorization": "Bearer $token"},
      data: {
        "fullName": name,
        "gender": gender,
        "nationality": nationality,
        "bio": bio,
       
      },
    );
    return response;
  }

  Future<Response> getAffiliateStatus({required String token}) async {
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/affiliates/me/status",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> createCoupon({
    required String token,
    required String code,
 
    required num discountPercentage,
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/affiliates/coupon",
      headers: {"Authorization": "Bearer $token"},
      data: {
        "code": code,
        "discountPercentage": discountPercentage,
      }
    );

    return response;
  }


  Future<Response> getCouponCodeByAffiliateId({required String token}) async{
    final response = await apiConsumer.get(
      "https://api-gateway.camion-app.com/affiliates/coupon/me",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }
}
