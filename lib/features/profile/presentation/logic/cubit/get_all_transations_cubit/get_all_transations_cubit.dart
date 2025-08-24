import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/profile/data/models/transaction_model/transactions.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_all_transations_state.dart';

class GetAllTransationsCubit extends Cubit<GetAllTransationsState> {
  GetAllTransationsCubit(this.profileRepository)
    : super(GetAllTransationsInitial());
  final ProfileRepository profileRepository;

  Future<void> getAllTransactions() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(GetAllTransationsLoading());
    final response = await profileRepository.getAllTransactions(token: token!);
    if (isClosed) return;
    response.fold((l) => emit(GetAllTransationsError(error: l)), (r) {
      emit(GetAllTransationsSuccess(data: r));
    });
  }
}
