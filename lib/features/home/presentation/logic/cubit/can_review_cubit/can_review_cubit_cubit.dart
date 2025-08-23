// import 'package:camion/core/api/api_error_model.dart';
// import 'package:camion/core/cache/secure_cache_storage.dart';
// import 'package:camion/core/services/service_locator.dart';
// import 'package:camion/features/home/data/repository/home_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'can_review_cubit_state.dart';

// class CanReviewCubitCubit extends Cubit<CanReviewCubitState> {
//   CanReviewCubitCubit(this.homeRepository) : super(CanReviewCubitInitial());
//   final HomeRepository homeRepository;

//   Future<void> canReview({
   
//     required String productId,
//   }) async {
//     final token = await sl<SecureCacheHelper>().getData(key: 'token');
//     emit(CanReviewCubitLoading());
//     final response = await homeRepository.canReview(
//       token: token!,
//       productId: productId,
//     );
//     response.fold(
//       (l) => emit(CanReviewCubitError(error: l)),
//       (r) => emit(CanReviewCubitSuccess(data: r)),
//     );
//   }
// }
