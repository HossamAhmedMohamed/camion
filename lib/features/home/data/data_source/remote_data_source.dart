// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:camion/core/api/api_consumer.dart';
import 'package:camion/core/api/end_points.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final ApiConsumer apiConsumer;
  HomeRemoteDataSource({required this.apiConsumer});

  Future<Response> getProducts({
    required int page,
    required int perPage,
  }) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/${EndPoints.products}",
      queryParameters: {"page": page, "per_page": perPage},
    );

    return response;
  }

  Future<Response> searchProducts({required String query}) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/${EndPoints.products}",
      queryParameters: {"search": query},
    );

    return response;
  }

  Future<Response> getProductById({
    required String id,
    required String token,
  }) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/${EndPoints.products}/$id",
      headers: {"Authorization": "Bearer $token"},
    );

    return response;
  }

  Future<Response> getStories({required String token}) async {
    final response = await apiConsumer.get(
      "https://stories.camion-app.com/${EndPoints.stories}/active",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> getStoryById({
    required String id,
    required String token,
  }) async {
    final response = await apiConsumer.get(
      "https://stories.camion-app.com/${EndPoints.stories}/$id",
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  Future<Response> getCategories() async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/categories",
    );

    return response;
  }

  Future<Response> getSubCategories({required int id}) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/categories/$id",
    );
    return response;
  }

  Future<Response> getProductsByCategory({required String slug , required int page,
    required int perPage,}) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/${EndPoints.products}",
      queryParameters: {"category": slug,
        "page": page,
        "per_page": perPage
      },
    );
    return response;
  }

  Future<Response> getProductsOnSale(
      {required int page, required int perPage})
  async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/products",

      queryParameters: {"on_sale": true , "page": page, "per_page": perPage},
    );
    return response;
  }

  Future<Response> getSliders() async {
    final response = await apiConsumer.get(
      "https://stories.camion-app.com/sliders",
    );
    return response;
  }

  Future<Response> sendFcmToken({
    required String fcmToken,
    required String token,
  }) async {
    final response = await apiConsumer.post(
      "https://api-gateway.camion-app.com/users/notifications/token",
      data: {"token": fcmToken},
      headers: {"Authorization": "Bearer $token"},
    );
    return response;
  }

  // Future<Response> canReview({
  //   required String token,
  //   required String productId,
  // }) async {
  //   final response = await apiConsumer.get(
  //     "https://api-gateway.camion-app.com/api/reviews/can-review/$productId",
  //     headers: {"Authorization": "Bearer $token"},
  //   );
  //   return response;
  // }

  Future<Response> createReview({
    required int productId,
    required String review,
    required double rating,
    required String reviewerName,
    required String reviewerEmail,
  }) async {
    final response = await apiConsumer.post(
      "https://buckydrop.camion-app.com/api/products/reviews",
      data: {
        "product_id": productId,
        "review": review,
        "rating": rating,
        "reviewer": reviewerName,
        "reviewer_email": reviewerEmail,
      },
    );
    return response;
  }

  Future<Response> getReviews({required String productId}) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/products/reviews",

      queryParameters: {"product": productId},
    );
    return response;
  }
}
