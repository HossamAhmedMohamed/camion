import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this.orderStatusRepo) : super(CreateOrderInitial());
  final OrderStatusRepository orderStatusRepo;

  Future<void> createOrder({
    required List<GetCartModel> cartList,
    required String taxPrice,
    required String shippingPrice,
    required String totalOrderPrice,
    required String shippingAddress,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    if (isClosed) {
      return;
    }
    emit(CreateOrderLoading());
    final result = await orderStatusRepo.createOrder(
      token: token!,
      userId: userId!,
      cartList: cartList,
      taxPrice: taxPrice,
      shippingPrice: shippingPrice,
      totalOrderPrice: totalOrderPrice,
      shippingAddress: shippingAddress,
    );

    if (isClosed) {
      return;
    }
    result.fold(
      (l) => emit(CreateOrderError(error: l)),
      (r) => emit(CreateOrderSuccess()),
    );
  }
}
