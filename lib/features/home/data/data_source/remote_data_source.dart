// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camion/core/api/api_consumer.dart';
import 'package:camion/core/api/end_points.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final ApiConsumer apiConsumer;
  HomeRemoteDataSource({required this.apiConsumer});


  Future<Response> getProducts() async {
    final response = await apiConsumer.get(
      EndPoints.products,
      queryParameters: {"keyword": "k"},
    );

    return response;
  }

  Future<Response> searchProducts({required String query}) async {
    final response = await apiConsumer.get(
      EndPoints.products,
      queryParameters: {"keyword": query},
    );

    return response;
  }
}
