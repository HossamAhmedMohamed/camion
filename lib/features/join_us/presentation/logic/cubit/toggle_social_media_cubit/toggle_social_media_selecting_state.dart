part of 'toggle_social_media_selecting_cubit.dart';

sealed class ToggleSocialMediaSelectingState {
  final List<int> selectedIndexes;

  ToggleSocialMediaSelectingState({required this.selectedIndexes});
}

final class ToggleSocialMediaSelectingInitial
    extends ToggleSocialMediaSelectingState {
  ToggleSocialMediaSelectingInitial() : super(selectedIndexes: []);
}

final class ToggleSocialMediaSelectingChanged
    extends ToggleSocialMediaSelectingState {
  ToggleSocialMediaSelectingChanged({required super.selectedIndexes});
}
