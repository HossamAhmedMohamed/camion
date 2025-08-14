part of 'affiliate_sign_cubit.dart';

sealed class AffiliateSignState {}

final class AffiliateSignInitial extends AffiliateSignState {}

final class AffiliateSignLoading extends AffiliateSignState {}

final class AffiliateSignSuccess extends AffiliateSignState {
  final AffiliateModel affiliateModel;

  AffiliateSignSuccess({required this.affiliateModel});
}

final class AffiliateSignError extends AffiliateSignState {
  final ApiErrorModel error;
  AffiliateSignError(this.error);
}
