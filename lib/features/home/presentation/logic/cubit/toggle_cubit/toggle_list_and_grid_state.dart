part of 'toggle_list_and_grid_cubit.dart';

sealed class ToggleListAndGridState {
  bool isListView;
  ToggleListAndGridState({required this.isListView});
}

final class ToggleListAndGridInitial extends ToggleListAndGridState {
  ToggleListAndGridInitial() : super(isListView: false);
}

final class ToggleListAndGridChanged extends ToggleListAndGridState {
  ToggleListAndGridChanged({required super.isListView});
}
