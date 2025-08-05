part of 'payment_method_cubit.dart';

sealed class PaymentMethodState {
  final int index;

  PaymentMethodState(this.index);
}

final class PaymentMethodInitial extends PaymentMethodState {
  PaymentMethodInitial() : super(-1);
}

final class PaymentMethodChanged extends PaymentMethodState {
  PaymentMethodChanged(super.index);
}
