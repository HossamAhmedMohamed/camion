import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_nav_bar_state.dart';

class ToggleNavBarCubit extends Cubit<ToggleNavBarState> {
  ToggleNavBarCubit() : super(ToggleNavBarInitial());

  void toggle(int index) {
    emit(ToggleNavBarChanged(index: index));
  }
}
