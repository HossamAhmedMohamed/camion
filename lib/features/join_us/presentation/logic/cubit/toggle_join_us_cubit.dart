import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_join_us_state.dart';

class ToggleJoinUsCubit extends Cubit<ToggleJoinUsState> {
  ToggleJoinUsCubit() : super(const ToggleInitial());

  void toggle(int index) {
    emit(ToggleChanged(index: index));
  }
}
