part of 'get_review_cubit.dart';


sealed class GetReviewState {}

final class GetReviewInitial extends GetReviewState {}

final class GetReviewLoading extends GetReviewState {}

final class GetReviewSuccess extends GetReviewState {
  final List<ReviewModel> reviews;
  GetReviewSuccess({required this.reviews});
}

final class GetReviewError extends GetReviewState {
  final ApiErrorModel error;
  GetReviewError({required this.error});
}
