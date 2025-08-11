import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/home/data/models/stories_model.dart/stories_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit(this.homeRepository) : super(StoriesInitial());
  final HomeRepository homeRepository;

  Future<void> getStories() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(StoriesLoading());
    final result = await homeRepository.getStories(token: token ?? '');
    result.fold(
      (error) {
        if (!isClosed) {
          emit(StoriesError(error: error));
        }
      },
      (stories) {
        if (!isClosed) {
          emit(StoriesLoaded(storiesList: stories));
        }
      },
    );
  }

  Future<void> getStoryById({required String id}) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(StoriesIdLoading());
    final result = await homeRepository.getStoryById(id: id, token: token!);
    result.fold(
      (error) {
        if (!isClosed) {
          emit(StoriesIdError(error: error));
        }
      },
      (story) {
        if (!isClosed) {
          emit(StoriesIdLoaded(storiesModel: story));
        }
      },
    );
  }
}
