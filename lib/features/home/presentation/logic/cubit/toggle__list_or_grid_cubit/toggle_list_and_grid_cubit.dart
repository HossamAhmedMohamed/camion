

import 'package:flutter_bloc/flutter_bloc.dart';
part 'toggle_list_and_grid_state.dart';

class ToggleListAndGridCubit extends Cubit<ToggleListAndGridState> {
  ToggleListAndGridCubit() : super(ToggleListAndGridInitial());


  void toggleView(bool isListView) {
    emit(ToggleListAndGridChanged(isListView: isListView));
  }
}
