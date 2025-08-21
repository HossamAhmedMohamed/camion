import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/order_status/data/models/tracking_order_model/tracking_order_model_response_model.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  OrderTrackingCubit(this.orderStatusRepository)
    : super(OrderTrackingInitial());
  final OrderStatusRepository orderStatusRepository;

  Future<void> getOrderTracking({required String orderId}) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(OrderTrackingLoading());
    final result = await orderStatusRepository.getOrderTracking(
      token: token!,
      orderId: orderId,
    );
    result.fold(
      (l) => emit(OrderTrackingError(error: l)),
      (r) => emit(OrderTrackingSuccess(trackingResponse: r)),
    );
  }
}
