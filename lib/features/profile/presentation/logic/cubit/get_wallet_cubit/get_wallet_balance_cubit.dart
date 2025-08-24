import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_wallet_balance_state.dart';

class GetWalletBalanceCubit extends Cubit<GetWalletBalanceState> {
  GetWalletBalanceCubit(this.profileRepository)
    : super(GetWalletBalanceInitial());
  final ProfileRepository profileRepository;

  Future<void> getWalletBalance() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(GetWalletBalanceLoading());
    final response = await profileRepository.getWalletBalance(token: token!);
    if (isClosed) return;
    response.fold((l) => emit(GetWalletBalanceError(error: l)), (r) {
      emit(GetWalletBalanceSuccess(data: r));
    });
  }
}
