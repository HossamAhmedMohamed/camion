part of 'order_tracking_cubit.dart';

sealed class OrderTrackingState {}

final class OrderTrackingInitial extends OrderTrackingState {}

final class OrderTrackingLoading extends OrderTrackingState {}

final class OrderTrackingSuccess extends OrderTrackingState {
  final TrackingResponse trackingResponse;
  OrderTrackingSuccess({required this.trackingResponse});
}

final class OrderTrackingError extends OrderTrackingState {
  final ApiErrorModel error;
  OrderTrackingError({required this.error});
}
