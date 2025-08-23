import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_review_state.dart';

class CreateReviewCubit extends Cubit<CreateReviewState> {
  CreateReviewCubit(this.homeRepository) : super(CreateReviewInitial());
  final HomeRepository homeRepository;

  Future<void> createReview({
    required int productId,
    required String review,
    required double rating,
  }) async {
    final userEmail = await sl<SecureCacheHelper>().getData(key: 'email');
    final userName = await sl<SecureCacheHelper>().getData(key: 'userName');
    emit(CreateReviewLoading());
    final response = await homeRepository.createReview(
     
      productId: productId,
      review: review,
      rating: rating,
      reviewerName: userName!,
      reviewerEmail: userEmail!,
    );
    response.fold(
      (l) => emit(CreateReviewError(error: l)),
      (r) => emit(CreateReviewSuccess()),
    );
  }
}
