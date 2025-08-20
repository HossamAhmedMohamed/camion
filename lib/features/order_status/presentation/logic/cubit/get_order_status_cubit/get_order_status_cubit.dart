import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/order_status/data/models/order_model/order_model.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_orders_cubit/get_orders_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_order_status_state.dart';

class GetOrderStatusCubit extends Cubit<GetOrdersState> {
  GetOrderStatusCubit(this.orderStatusRepository)
    : super(GetOrdersInitial());
  final OrderStatusRepository orderStatusRepository;

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
