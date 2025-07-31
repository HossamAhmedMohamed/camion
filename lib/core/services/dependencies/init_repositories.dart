import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/home/data/data_source/remote_data_source.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';

Future<void> initRepositories() async {
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(apiConsumer: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(remoteDataSource: sl()),
  );
}
