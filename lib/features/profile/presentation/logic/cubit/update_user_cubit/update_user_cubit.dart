import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/profile/data/models/get_user_model/user_model.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this.profileRepository) : super(UpdateUserInitial());
  final ProfileRepository profileRepository;

  Future<void> updateUser({required Map<String, dynamic> data}) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    emit(UpdateUserLoading());
    final response = await profileRepository.updateUser(
      token: token!,
      userId: userId!,
      data: data,
    );
    response.fold((l) => emit(UpdateUserError(error: l)), (r) {
      emit(UpdateUserLoaded(user: r));
    });
  }
}
