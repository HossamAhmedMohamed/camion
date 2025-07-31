import 'dart:developer';

import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/data_source/remote_data_source.dart';
import 'package:camion/features/home/data/models/product_model/product_model.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
  HomeRemoteDataSource remoteDataSource;

  HomeRepository({required this.remoteDataSource});

  Future<Either<ApiErrorModel, List<ProductsModel>>> getProducts() async {
    try {
      final response = await remoteDataSource.getProducts();

      List<ProductsModel> products = [];

      for (var product in response.data["data"]["records"]) {
        products.add(ProductsModel.fromJson(product));
      }
      return Right(products);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<ProductsModel>>> searchProducts({
    required String query,
  }) async {
    try {
      final response = await remoteDataSource.searchProducts(query: query);
      final products = (response.data["data"]["records"] as List)
          .map((product) => ProductsModel.fromJson(product))
          .toList();
      return Right(products);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }
}
