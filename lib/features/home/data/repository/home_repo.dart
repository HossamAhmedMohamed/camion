import 'dart:developer';

import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/data_source/remote_data_source.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/data/models/reviews_model/review_model.dart';
import 'package:camion/features/home/data/models/slider_items/slider_item_model.dart';
import 'package:camion/features/home/data/models/stories_model.dart/stories_model.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
  HomeRemoteDataSource remoteDataSource;

  HomeRepository({required this.remoteDataSource});

  Future<Either<ApiErrorModel, List<AllProductModel>>> getProducts({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await remoteDataSource.getProducts(
        page: page,
        perPage: perPage,
      );

      List<AllProductModel> products = [];

      for (var product in response.data["products"]) {
        products.add(AllProductModel.fromJson(product));
      }
      return Right(products);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<AllProductModel>>> searchProducts({
    required String query,
  }) async {
    try {
      final response = await remoteDataSource.searchProducts(query: query);
      final products = (response.data["products"] as List)
          .map((product) => AllProductModel.fromJson(product))
          .toList();
      return Right(products);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, AllProductModel>> getProductById({
    required String id,
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.getProductById(
        id: id,
        token: token,
      );
      return Right(AllProductModel.fromJson(response.data));
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<StoriesModel>>> getStories({
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.getStories(token: token);
      final stories = (response.data as List)
          .map((story) => StoriesModel.fromJson(story))
          .toList();
      return Right(stories);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, StoriesModel>> getStoryById({
    required String id,
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.getStoryById(
        id: id,
        token: token,
      );
      return Right(StoriesModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<GeTCategoriesModel>>>
  getCategories() async {
    try {
      final response = await remoteDataSource.getCategories();
      final categories = (response.data as List)
          .map((category) => GeTCategoriesModel.fromJson(category))
          .toList();
      return Right(categories);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<GeTCategoriesModel>>> getSubCategories({
    required int id,
  }) async {
    try {
      final response = await remoteDataSource.getSubCategories(id: id);
      final products = (response.data["subcategories"] as List)
          .map((product) => GeTCategoriesModel.fromJson(product))
          .toList();
      return Right(products);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<AllProductModel>>> getProductsByCategory({
    required String slug,
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await remoteDataSource.getProductsByCategory(
        slug: slug,

        page: page,
        perPage: perPage,
      );

      List<AllProductModel> products = [];

      for (var product in response.data["products"]) {
        products.add(AllProductModel.fromJson(product));
      }

      return Right(products);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<AllProductModel>>> getProductsOnSale({
   
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await remoteDataSource.getProductsOnSale(
        page: page,
        perPage: perPage,
      );

      List<AllProductModel> products = [];

      for (var product in response.data["products"]) {
        products.add(AllProductModel.fromJson(product));
      }

      return Right(products);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }

  // Future<Either<ApiErrorModel, StoriesModel>> getStoryById({
  //   required String id,
  //   required String token
  // }) async {
  //   try {
  //     final response = await remoteDataSource.getStoryById(id: id , token: token);
  //     return Right(StoriesModel.fromJson(response.data));
  //   } catch (e) {
  //     return left(ApiErrorHandler.handle(e));
  //   }
  // }

  Future<Either<ApiErrorModel, List<SliderItemModel>>> getSliders() async {
    try {
      final response = await remoteDataSource.getSliders();
      final sliders = (response.data as List)
          .map((slider) => SliderItemModel.fromJson(slider))
          .toList();
      return Right(sliders);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, dynamic>> sendFcmToken({
    required String fcmToken,
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.sendFcmToken(
        fcmToken: fcmToken,
        token: token,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  // Future<Either<ApiErrorModel, dynamic>> canReview({
  //   required String token,
  //   required String productId,
  // }) async {
  //   try {
  //     final response = await remoteDataSource.canReview(
  //       token: token,
  //       productId: productId,
  //     );
  //     return Right(response.data);
  //   } catch (e) {
  //     return left(ApiErrorHandler.handle(e));
  //   }
  // }

  Future<Either<ApiErrorModel, dynamic>> createReview({
    required int productId,
    required String review,
    required double rating,
    required String reviewerName,
    required String reviewerEmail,
  }) async {
    try {
      final response = await remoteDataSource.createReview(
        productId: productId,
        review: review,
        rating: rating,
        reviewerName: reviewerName,
        reviewerEmail: reviewerEmail,
      );
      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<ReviewModel>>> getReviews({
    required String productId,
  }) async {
    try {
      final response = await remoteDataSource.getReviews(productId: productId);
      final List<ReviewModel> reviews = (response.data as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList();
      return Right(reviews);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }
}
