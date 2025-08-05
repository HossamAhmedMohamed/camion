import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:camion/features/cart/data/data_source/remote_data_source.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/home/data/data_source/remote_data_source.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/order_status/data/data_source/remote_data_source.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:camion/features/wish_list/data/data_source/remote_data_source.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';

Future<void> initRepositories() async {
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(apiConsumer: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(apiConsumer: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(authRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSource(apiConsumer: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepository(cartRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<WishListRemoteDataSource>(
    () => WishListRemoteDataSource(apiConsumer: sl()),
  );

  sl.registerLazySingleton<WishListRepository>(
    () => WishListRepository(wishListRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<OrderStatusRemoteDataSource>(
    () => OrderStatusRemoteDataSource(apiConsumer: sl()),
  );

  sl.registerLazySingleton<OrderStatusRepository>(
    () => OrderStatusRepository(orderStatusRemoteDataSource: sl()),
  );
}
