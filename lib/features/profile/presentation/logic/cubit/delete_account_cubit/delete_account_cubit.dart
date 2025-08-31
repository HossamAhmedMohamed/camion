import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.profileRepository) : super(DeleteAccountInitial());
  final ProfileRepository profileRepository;

  Future<void> deleteAccount() async {
    final token = await sl<SecureCacheHelper>().getData(key: "token");
    final userId = await sl<SecureCacheHelper>().getData(key: "id");
    emit(DeleteAccountLoading());
    final result = await profileRepository.deleteAccount(
      token: token!,
      userId: userId!,
    );
    result.fold((error) => emit(DeleteAccountFailure(error: error)), (_) async {
      await Future.wait([
        sl<SecureCacheHelper>().removeData(key: 'token'),
        sl<SecureCacheHelper>().removeData(key: 'id'),
        sl<SecureCacheHelper>().removeData(key: 'userRole'),
        sl<SecureCacheHelper>().removeData(key: 'email'),
        sl<SecureCacheHelper>().removeData(key: 'phoneNumber'),
        sl<SecureCacheHelper>().removeData(key: 'userName'),
      ]);
      emit(DeleteAccountSuccess());
    });
  }
}
