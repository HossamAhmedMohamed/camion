import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_add_cart_state.dart';

class ToggleAddCartCubit extends Cubit<ToggleAddCartState> {
  ToggleAddCartCubit() : super(const ToggleAddCartInitial());

  void toggleAddCart(int index) {
    emit(ToggleAddCartChanged(index: index));
  }
}
