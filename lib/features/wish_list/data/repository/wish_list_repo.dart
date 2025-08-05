import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/wish_list/data/data_source/remote_data_source.dart';
import 'package:camion/features/wish_list/data/models/get_wish_list_model.dart';
import 'package:dartz/dartz.dart';

class WishListRepository {
  final WishListRemoteDataSource wishListRemoteDataSource;

  WishListRepository({required this.wishListRemoteDataSource});

  Future<Either<ApiErrorModel, dynamic>> addToWishList({
    required String token,
    required String userId,
    required String productId,
    required String title,
    required int price,
    required String image,
  }) async {
    try {
      final response = await wishListRemoteDataSource.addToWishList(
        token: token,
        userId: userId,
        productId: productId,
        title: title,
        price: price,
        image: image,
      );

      return Right(response.data);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<GetWishListModel>>> getWishList({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await wishListRemoteDataSource.getWishList(
        token: token,
        userId: userId,
      );

      final List<GetWishListModel> wishList = (response.data as List)
          .map((wishList) => GetWishListModel.fromJson(wishList))
          .toList();

      return Right(wishList);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
