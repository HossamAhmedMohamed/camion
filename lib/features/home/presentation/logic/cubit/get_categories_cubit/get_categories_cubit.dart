import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit(this.homeRepository) : super(GetCategoriesInitial());
  final HomeRepository homeRepository;

  Future<void> getCategories() async {
    if (isClosed) return;
    emit(GetCategoriesLoading());
    final result = await homeRepository.getCategories();
    result.fold(
      (error) {
        if (!isClosed) {
          emit(GetCategoriesError(error: error));
        }
      },
      (categories) {
        if (!isClosed) {
          emit(GetCategoriesSuccess(categories: categories));
        }
      },
    );
  }
}
