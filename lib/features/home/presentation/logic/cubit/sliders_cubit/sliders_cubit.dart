 
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/slider_items/slider_item_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

part 'sliders_state.dart';

class SlidersCubit extends Cubit<SlidersState> {
  SlidersCubit(this.homeRepository) : super(SlidersInitial());
  final HomeRepository homeRepository;


  Future<void> getSliders() async {
    if(isClosed) return;
    emit(GetAllSlidersLoading());
    final result = await homeRepository.getSliders();
    if(isClosed) return;
    result.fold(
      (error) {
        emit(GetAllSlidersError(error: error));
      },
      (sliders) {
        emit(GetAllSlidersLoaded(slidersList: sliders));
      },
    );
  }
}
