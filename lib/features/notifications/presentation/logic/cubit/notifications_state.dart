part of 'notifications_cubit.dart';


sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoadingState extends NotificationsState {}

final class NotificationsLoadedState extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoadedState(this.notifications);
}

final class NotificationsErrorState extends NotificationsState {
  final ApiErrorModel error;
  NotificationsErrorState(this.error);
}
