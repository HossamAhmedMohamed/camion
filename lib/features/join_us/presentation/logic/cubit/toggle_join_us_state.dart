part of 'toggle_join_us_cubit.dart';

 
sealed class ToggleJoinUsState {
  final int index;
  const ToggleJoinUsState({required this.index});
}

final class ToggleInitial extends ToggleJoinUsState {
  const ToggleInitial(): super(index: -1);
}

final class ToggleChanged extends ToggleJoinUsState {
  const ToggleChanged({required super.index});
}
