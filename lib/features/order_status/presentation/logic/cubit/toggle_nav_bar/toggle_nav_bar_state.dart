part of 'toggle_nav_bar_cubit.dart';

 
sealed class ToggleNavBarState {
    int index;

    ToggleNavBarState({required this.index});
}

final class ToggleNavBarInitial extends ToggleNavBarState {
    ToggleNavBarInitial() : super(index: 0);
}

final class ToggleNavBarChanged extends ToggleNavBarState {
    ToggleNavBarChanged({required super.index});
}
