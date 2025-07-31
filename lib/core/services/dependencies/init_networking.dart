import 'package:camion/core/api/api_consumer.dart';
import 'package:camion/core/api/dio_consumer.dart';
 
import 'package:camion/core/services/service_locator.dart';

Future<void> initNetworking() async {
  sl.registerSingleton<ApiConsumer>(DioConsumer(dio: sl()));
 
}
