import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_sub_categories_state.dart';

class GetSubCategoriesCubit extends Cubit<GetSubCategoriesState> {
  GetSubCategoriesCubit(this.homeRepository) : super(GetSubCategoriesInitial());
  final HomeRepository homeRepository;

  Future<void> getSubCategories({
    required String lang,
    required int id}) async {
    if (isClosed) return;
    emit(GetSubCategoriesLoading());
    final response = await homeRepository.getSubCategories(
      lang: lang,
      id: id);
    if (isClosed) return;
    response.fold(
      (l) => emit(GetSubCategoriesError(error: l)),
      (r) => emit(GetSubCategoriesSuccess(subCategories: r)),
    );
  }
}
