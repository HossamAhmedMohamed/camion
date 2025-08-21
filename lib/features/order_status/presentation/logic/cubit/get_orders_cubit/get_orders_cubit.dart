import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/order_status/data/models/order_model/order_model.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit(this.orderStatusRepository) : super(GetOrdersInitial());
  final OrderStatusRepository orderStatusRepository;

  Future<void> getOrders() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    if (isClosed) {
      return;
    }
    emit(GetOrdersLoading());

    final result = await orderStatusRepository.getOrders(
      token: token!,
      userId: userId!,
    );

    if (isClosed) {
      return;
    }
    result.fold(
      (l) => emit(GetOrdersError(error: l)),
      (r) => emit(GetOrdersSuccess(orders: r)),
    );
  }

  Future<void> getOrderStatus({required String status}) async {
    if (isClosed) return;

    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(GetOrdersLoading());
    final result = await orderStatusRepository.getOrderStatus(
      token: token!,
      status: status,
    );
    if (isClosed) return;
    result.fold(
      (l) => emit(GetOrdersError(error: l)),
      (r) => emit(GetOrdersSuccess(orders: r)),
    );
  }
}
