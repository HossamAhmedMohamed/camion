import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/notifications/push_notification.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'send_fcm_oken_state.dart';

class SendFcmTokenCubit extends Cubit<SendFcmOkenState> {
  SendFcmTokenCubit(this.homeRepository) : super(SendFcmOkenInitial());
  final HomeRepository homeRepository;

  void sendFcmToken() async {
    final fcmToken = PushNotificationsService.token;
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if(isClosed) return;
    emit(SendFcmOkenLoading());
    final response = await homeRepository.sendFcmToken(
      fcmToken: fcmToken!,
      token: token!,
    );
    if(isClosed) return;
    response.fold(
      (error) => emit(SendFcmOkenError(error)),
      (data) => emit(SendFcmOkenSuccess()),
    );
  }
}
