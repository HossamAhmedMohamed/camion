import 'package:camion/core/cache/cache_helper.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart' show sl;
import 'package:dio/dio.dart';

Future<void> initCore() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<CacheHelper>(CacheHelper());
  sl.registerSingleton<SecureCacheHelper>(SecureCacheHelper());
}
