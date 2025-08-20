import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_nav_bar_state.dart';

class ToggleNavBarCubit extends Cubit<ToggleNavBarState> {
  ToggleNavBarCubit() : super(ToggleNavBarInitial());

  Future<void> toggle(int index) async{
    emit(ToggleNavBarChanged(index: index));
  }
}
