// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camion/core/api/api_consumer.dart';
import 'package:camion/core/api/end_points.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final ApiConsumer apiConsumer;
  HomeRemoteDataSource({required this.apiConsumer});

  Future<Response> getProducts() async {
    final response = await apiConsumer.get(
      "http://54.162.75.209:3000/api/buckydrop/${EndPoints.products}",
      queryParameters: {"keyword": "k"},
    );

    return response;
  }

  Future<Response> searchProducts({required String query}) async {
    final response = await apiConsumer.get(
      "http://54.162.75.209:3000/api/buckydrop/${EndPoints.products}",
      queryParameters: {"keyword": query},
    );

    return response;
  }

  Future<Response> getProductById({required String id}) async {
    final response = await apiConsumer.get(
      "http://54.162.75.209:3000/api/buckydrop/${EndPoints.products}/$id",
    );

    return response;
  }

  Future<Response> getStories() async {
    final response = await apiConsumer.get(
      "http://stories.camion-app.com:6000/${EndPoints.stories}",
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjNDYzN2NhYS1iMTcxLTRiZWUtYWZiMC01ZDM2M2ZhYTFiOTQiLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicGhvbmUiOiIrMjAxMTE2MDY0MjkxIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTM5NzUxMjQsImV4cCI6MTc1NDU3OTkyNH0.KfH4PmaNYk4H-G7HiNe9tZFV_bEwLxKDOQb3zaxSmoA",
      },
    );
    return response;
  }

  Future<Response> getStoryById({required String id}) async {
    final response = await apiConsumer.get(
      "http://stories.camion-app.com:6000/${EndPoints.stories}/$id",
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjNDYzN2NhYS1iMTcxLTRiZWUtYWZiMC01ZDM2M2ZhYTFiOTQiLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicGhvbmUiOiIrMjAxMTE2MDY0MjkxIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTM5NzUxMjQsImV4cCI6MTc1NDU3OTkyNH0.KfH4PmaNYk4H-G7HiNe9tZFV_bEwLxKDOQb3zaxSmoA",
      },
    );
    return response;
  }
}
