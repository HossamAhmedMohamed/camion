part of 'stories_cubit.dart';

sealed class StoriesState {}

final class StoriesInitial extends StoriesState {}

final class StoriesLoading extends StoriesState {}

final class StoriesLoaded extends StoriesState {
  final List<StoriesModel> storiesList;
  StoriesLoaded({required this.storiesList});
}

final class StoriesError extends StoriesState {
  final ApiErrorModel error;
  StoriesError({required this.error});
}

final class StoriesIdLoading extends StoriesState {}

final class StoriesIdLoaded extends StoriesState {
  final StoriesModel storiesModel;
  StoriesIdLoaded({required this.storiesModel});
}

final class StoriesIdError extends StoriesState {
  final ApiErrorModel error;
  StoriesIdError({required this.error});
}
