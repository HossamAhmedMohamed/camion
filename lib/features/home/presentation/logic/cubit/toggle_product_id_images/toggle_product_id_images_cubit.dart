import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_product_id_images_state.dart';

class ToggleProductIdImagesCubit extends Cubit<ToggleProductIdImagesState> {
  ToggleProductIdImagesCubit() : super(ToggleProductIdImagesInitial());

  void toggle(int index) {
    emit(ToggleProductIdImagesChanged(index: index));
  }
}
