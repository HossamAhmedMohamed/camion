import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/order_status/data/models/order_response_model/order_response_model.dart';

import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this.orderStatusRepo) : super(CreateOrderInitial());
  final OrderStatusRepository orderStatusRepo;

  // Future<void> calculateShippingAddress({
  //   required List<GetCartModel> items,
  //   required String shippingFirstName,
  //   required String shippingLastName,
  //   required String shippingAddress1,
  //   required String shippingAddress2,
  //   required String shippingCity,
  //   required String shippingState,
  //   required String shippingPostcode,
  //   required String shippingCountry,
  // }) async {
  //   emit(CalculateShippingAddressLoading());
  //   final result = await orderStatusRepo.calculateShippingAddress(
  //     items: items,
  //     shippingFirstName: shippingFirstName,
  //     shippingLastName: shippingLastName,
  //     shippingAddress1: shippingAddress1,
  //     shippingAddress2: shippingAddress2,
  //     shippingCity: shippingCity,
  //     shippingState: shippingState,
  //     shippingPostcode: shippingPostcode,
  //     shippingCountry: shippingCountry,
  //   );
  //   result.fold(
  //     (l) => emit(CalculateShippingAddressError(error: l)),
  //     (r) => emit(CalculateShippingAddressSuccess(shippingMethods: r)),
  //   );
  // }

  Future<void> createOrder() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    // final userId = await sl<SecureCacheHelper>().getData(key: 'id');

    if (isClosed) {
      return;
    }

    emit(CreateOrderLoading());

    final result = await orderStatusRepo.createOrder(token: token!);

    if (isClosed) {
      return;
    }

    result.fold(
      (l) => emit(CreateOrderError(error: l)),
      (r) => emit(CreateOrderSuccess(order: r)),
    );
  }
}
