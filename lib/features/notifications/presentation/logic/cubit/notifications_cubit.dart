import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/notifications/data/models/notification_model.dart';
import 'package:camion/features/notifications/data/repository/notification_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.notificationRepository)
    : super(NotificationsInitial());
  final NotificationRepository notificationRepository;

  Future<void> getNotifications() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(NotificationsLoadingState());
    final notifications = await notificationRepository.getNotifications(
      token: token!,
    );
    if (isClosed) return;
    notifications.fold(
      (failure) => emit(NotificationsErrorState(failure)),
      (notifications) => emit(NotificationsLoadedState(notifications)),
    );
  }
}
