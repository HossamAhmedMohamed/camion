import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  void changeIndex(int index) {
    emit(PaymentMethodChanged(index));
  }
}



