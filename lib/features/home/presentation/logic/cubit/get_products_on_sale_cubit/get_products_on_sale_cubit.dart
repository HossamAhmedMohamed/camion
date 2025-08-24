import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_products_on_sale_state.dart';

class GetProductsOnSaleCubit extends Cubit<GetProductsOnSaleState> {
  GetProductsOnSaleCubit(this.homeRepository)
    : super(GetProductsOnSaleInitial());
  final HomeRepository homeRepository;

  int currentPage = 1;
  final int perPage = 6;
  bool hasMore = true;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasLoadMoreError = false;

  List<AllProductModel> allProducts = [];

  Future<void> getProductsOnSale({bool isLoadMore = false}) async {
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
      emit(GetProductsOnSaleLoading());
    } else {
      isLoadingMore = true;
      hasLoadMoreError = false;
      isLoading = true;
      emit(GetProductsOnSaleSuccess(products: allProducts));
    }

    final response = await homeRepository.getProductsOnSale(
      page: currentPage,
      perPage: perPage,
    );

    if (isClosed) {
      return;
    }

    response.fold(
      (l) {
        if (isLoadMore) {
          isLoadingMore = false;
          hasLoadMoreError = true;
          emit(GetProductsOnSaleSuccess(products: allProducts));
        } else {
          isLoadingMore = false;
          hasLoadMoreError = false;
          emit(GetProductsOnSaleError(error: l));
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
          emit(GetProductsOnSaleSuccess(products: allProducts));
        }
      },
    );
  }
}
