import 'dart:developer';

import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  void logOut() async {
    log('logout');
    await Future.wait([
      sl<SecureCacheHelper>().removeData(key: 'token'),
      sl<SecureCacheHelper>().removeData(key: 'id'),
      sl<SecureCacheHelper>().removeData(key: 'userRole'),
      sl<SecureCacheHelper>().removeData(key: 'email'),
      sl<SecureCacheHelper>().removeData(key: 'phoneNumber'),
      sl<SecureCacheHelper>().removeData(key: 'userName'),
    ]);
  }
}
