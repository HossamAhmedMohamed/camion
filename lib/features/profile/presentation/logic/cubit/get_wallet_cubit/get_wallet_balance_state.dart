part of 'get_wallet_balance_cubit.dart';

sealed class GetWalletBalanceState {}

final class GetWalletBalanceInitial extends GetWalletBalanceState {}

final class GetWalletBalanceLoading extends GetWalletBalanceState {}

final class GetWalletBalanceSuccess extends GetWalletBalanceState {
  dynamic data;
  GetWalletBalanceSuccess({required this.data});
}


final class GetWalletBalanceError extends GetWalletBalanceState {
  final ApiErrorModel error;
  GetWalletBalanceError({required this.error});
}
