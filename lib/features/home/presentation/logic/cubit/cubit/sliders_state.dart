part of 'sliders_cubit.dart';

 
sealed class SlidersState {}

final class SlidersInitial extends SlidersState {}
final class GetAllSlidersLoading extends SlidersState {}

final class GetAllSlidersLoaded extends SlidersState {
  final List<SliderItemModel> slidersList;
  GetAllSlidersLoaded({required this.slidersList});
}

final class GetAllSlidersError extends SlidersState {
  final ApiErrorModel error;
  GetAllSlidersError({required this.error});
}