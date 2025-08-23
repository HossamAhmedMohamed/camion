part of 'create_review_cubit.dart';

sealed class CreateReviewState {}

final class CreateReviewInitial extends CreateReviewState {}

final class CreateReviewLoading extends CreateReviewState {}

final class CreateReviewSuccess extends CreateReviewState {}

final class CreateReviewError extends CreateReviewState {
  final ApiErrorModel error;
  CreateReviewError({required this.error});
}
