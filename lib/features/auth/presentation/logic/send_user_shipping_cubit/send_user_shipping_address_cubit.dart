import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'send_user_shipping_address_state.dart';

class SendUserShippingAddressCubit extends Cubit<SendUserShippingAddressState> {
  SendUserShippingAddressCubit(this.authRepository)
    : super(SendUserShippingAddressInitial());
  final AuthRepository authRepository;

  sendUserShippingAddress({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String postcode,
    required String country,
    required String shippingFirstName,
    required String shippingLastName,
    required String shippingAddress1,
    required String shippingAddress2,
    required String shippingCity,
    required String shippingState,
    required String shippingPostcode,
    required String shippingCountry,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(SendUserShippingAddressLoading());
    final result = await authRepository.sendUserShippingAddress(
      token: token!,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      address1: address1,
      address2: address2,
      city: city,
      state: state,
      postcode: postcode,
      country: country,
      shippingFirstName: shippingFirstName,
      shippingLastName: shippingLastName,
      shippingAddress1: shippingAddress1,
      shippingAddress2: shippingAddress2,
      shippingCity: shippingCity,
      shippingState: shippingState,
      shippingPostcode: shippingPostcode,
      shippingCountry: shippingCountry,
    );
    result.fold(
      (error) => emit(SendUserShippingAddressError(error: error)),
      (data) => emit(SendUserShippingAddressLoaded()),
    );
  }
}
