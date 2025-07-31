import 'package:camion/core/services/dependencies/init_core.dart';
import 'package:camion/core/services/dependencies/init_networking.dart';
import 'package:camion/core/services/dependencies/init_repositories.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await initCore();
  await initNetworking();
  await initRepositories();
  
}
