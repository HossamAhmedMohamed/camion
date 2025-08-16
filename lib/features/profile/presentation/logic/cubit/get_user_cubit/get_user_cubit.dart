import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/profile/data/models/get_user_model/user_model.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit(this.profileRepository) : super(GetUserInitial());
  final ProfileRepository profileRepository;

  Future<void> getUserById() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    if (isClosed) return;
    emit(GetUserLoading());
    final response = await profileRepository.getUserById(
      token: token!,
      userId: userId!,
    );
    if (isClosed) return;
    response.fold((l) => emit(GetUserError(error: l)), (r) {
      emit(GetUserLoaded(user: r));
    });
  }
}
