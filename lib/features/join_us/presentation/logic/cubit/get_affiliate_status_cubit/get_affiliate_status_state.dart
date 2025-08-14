part of 'get_affiliate_status_cubit.dart';

 
sealed class GetAffiliateStatusState {}

final class GetAffiliateStatusInitial extends GetAffiliateStatusState {}

final class GetAffiliateStatusLoading extends GetAffiliateStatusState {}

final class GetAffiliateStatusSuccess extends GetAffiliateStatusState {
  final AffiliateStatus data;
  GetAffiliateStatusSuccess({required this.data});
}

final class GetAffiliateStatusError extends GetAffiliateStatusState {
  final ApiErrorModel error;
  GetAffiliateStatusError({required this.error});
}
