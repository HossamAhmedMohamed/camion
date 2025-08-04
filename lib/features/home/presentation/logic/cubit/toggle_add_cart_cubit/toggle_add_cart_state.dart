part of 'toggle_add_cart_cubit.dart';

sealed class ToggleAddCartState {
  final int index;

  const ToggleAddCartState({required this.index });
}

final class ToggleAddCartInitial extends ToggleAddCartState {
  const ToggleAddCartInitial(): super(index: 0);
}

final class ToggleAddCartChanged extends ToggleAddCartState {
  const ToggleAddCartChanged({required super.index});
}
