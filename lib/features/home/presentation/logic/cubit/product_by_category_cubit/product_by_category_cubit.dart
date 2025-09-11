import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_by_category_state.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  ProductByCategoryCubit(this.homeRepository)
    : super(ProductByCategoryInitial());
  final HomeRepository homeRepository;

  int currentPage = 1;
  final int perPage = 6;
  bool hasMore = true;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasLoadMoreError = false;

  List<AllProductModel> allProducts = [];

  Future<void> getProductsByCategory({
    required String slug,
    required String lang,
    bool isLoadMore = false,
  }) async {
    if (!hasMore && isLoadMore) return;
    if (isLoading) return;
    if (isClosed) return;
    if (!isLoadMore) {
      currentPage = 1;
      allProducts.clear();
      hasMore = true;
      isLoadingMore = false;
      hasLoadMoreError = false;
      isLoading = true;
      emit(ProductByCategoryLoading());
    } else {
      isLoadingMore = true;
      hasLoadMoreError = false;
      isLoading = true;
      emit(ProductByCategoryLoaded(products: allProducts));
    }
    final response = await homeRepository.getProductsByCategory(
      slug: slug,
      page: currentPage,
      perPage: perPage,
      lang: lang,
    );
    if (isClosed) {
      return;
    }
    response.fold(
      (l) {
        if (isLoadMore) {
          isLoadingMore = false;
          hasLoadMoreError = true;
          emit(ProductByCategoryLoaded(products: allProducts));
        } else {
          isLoadingMore = false;
          hasLoadMoreError = false;
          emit(ProductByCategoryError(error: l));
        }
      },
      (r) {
        if (r.isEmpty) {
          hasMore = false;
        } else {
          allProducts.addAll(r);
          currentPage++;
        }
        if (!isClosed) {
          isLoading = false;
          isLoadingMore = false;
          hasLoadMoreError = false;
          emit(ProductByCategoryLoaded(products: allProducts));
        }
      },
    );
  }
}
