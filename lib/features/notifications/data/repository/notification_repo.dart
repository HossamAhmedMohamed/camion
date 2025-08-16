import 'package:camion/core/api/api_error_handler.dart';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/notifications/data/data_source/remote_data_source.dart';
import 'package:camion/features/notifications/data/models/notification_model.dart';
import 'package:dartz/dartz.dart';

class NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepository({required this.notificationRemoteDataSource});

  Future<Either<ApiErrorModel, List<NotificationModel>>> getNotifications({
    required String token,
  }) async {
    try {
      final response = await notificationRemoteDataSource.getNotifications(
        token: token,
      );
      final notifications = (response.data as List)
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();
      return Right(notifications);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
