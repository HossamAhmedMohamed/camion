import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_by_category_state.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  ProductByCategoryCubit(this.homeRepository)
    : super(ProductByCategoryInitial());
  final HomeRepository homeRepository;

  Future<void> getProductsByCategory({required String slug}) async {
    if (isClosed) return;
    emit(ProductByCategoryLoading());
    final response = await homeRepository.getProductsByCategory(slug: slug);
    if (isClosed) {
      return;
    }
    response.fold(
      (l) => emit(ProductByCategoryError(error: l)),
      (r) => emit(ProductByCategoryLoaded(products: r)),
    );
  }
}
