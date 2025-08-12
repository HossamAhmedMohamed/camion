part of 'supplier_sign_cubit.dart';

sealed class SupplierSignState {}

final class SupplierSignInitial extends SupplierSignState {}

final class SupplierSignLoading extends SupplierSignState {}

final class SupplierSignSuccess extends SupplierSignState {
  final AffiliateModel affiliateModel;

  SupplierSignSuccess({required this.affiliateModel});
}

final class SupplierSignError extends SupplierSignState {
  final ApiErrorModel error;
  SupplierSignError(this.error);
}
