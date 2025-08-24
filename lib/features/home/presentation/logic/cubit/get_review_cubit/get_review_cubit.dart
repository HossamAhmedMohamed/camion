import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/reviews_model/review_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_review_state.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  GetReviewCubit(this.homeRepository) : super(GetReviewInitial());
  final HomeRepository homeRepository;

  Future<void> getReviews({required String productId}) async {
    if (isClosed) return;
    emit(GetReviewLoading());
    final response = await homeRepository.getReviews(productId: productId);
    if (isClosed) return;
    response.fold(
      (l) => emit(GetReviewError(error: l)),
      (r) => emit(GetReviewSuccess(reviews: r)),
    );
  }
}
