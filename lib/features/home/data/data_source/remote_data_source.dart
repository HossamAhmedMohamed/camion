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

  Future<Response> getStories(
    {
      required String token
    }
  ) async {
    final response = await apiConsumer.get(
      "https://stories.camion-app.com/${EndPoints.stories}/active",
      headers: {
        "Authorization":
            "Bearer $token",
      },
    );
    return response;
  }

  Future<Response> getStoryById({required String id , required String token}) async {
    final response = await apiConsumer.get(
      "https://stories.camion-app.com/${EndPoints.stories}/$id",
      headers: {
        "Authorization":
            "Bearer $token",
      },
    );
    return response;
  }

  Future<Response> getCategories() async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/categories",
    );

    return response;
  }

  Future<Response> getProductsByCategory({required String slug}) async {
    final response = await apiConsumer.get(
      "https://buckydrop.camion-app.com/api/${EndPoints.products}",
      queryParameters: {"category": slug},
    );
    return response;
  }
}
