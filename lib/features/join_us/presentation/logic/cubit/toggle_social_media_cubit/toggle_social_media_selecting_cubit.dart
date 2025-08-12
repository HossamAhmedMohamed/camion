import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_social_media_selecting_state.dart';

class ToggleSocialMediaSelectingCubit
    extends Cubit<ToggleSocialMediaSelectingState> {
  ToggleSocialMediaSelectingCubit()
    : super(ToggleSocialMediaSelectingInitial());

  void toggle(int index) {
    final currentIndexes = List<int>.from(state.selectedIndexes);

    if (currentIndexes.contains(index)) {
      currentIndexes.remove(index);
    } else {
      currentIndexes.add(index);
    }

    emit(ToggleSocialMediaSelectingChanged(selectedIndexes: currentIndexes));
  }
}
