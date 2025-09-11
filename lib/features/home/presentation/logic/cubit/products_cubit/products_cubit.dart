import 'dart:async';
import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.homeRepository) : super(ProductsInitial());

  final HomeRepository homeRepository;

  int currentPage = 1;
  final int perPage = 6;
  bool hasMore = true;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasLoadMoreError = false;

  List<AllProductModel> allProducts = [];

  bool isSearching = false;

  Timer? _debounce;

  Future<void> getProducts({bool isLoadMore = false , required String lang}) async {
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
      emit(ProductsLoading());
    } else {
      isLoadingMore = true;
      hasLoadMoreError = false;
      isLoading = true;
      emit(ProductsLoaded(products: allProducts, isSearching: false));
    }

    // emit(ProductsLoading());

    final result = await homeRepository.getProducts(
      page: currentPage,
      perPage: perPage,
      lang: lang,
    );
    result.fold(
      (error) {
        isLoading = false;

        if (!isClosed) {
          if (isLoadMore) {
            isLoadingMore = false;
            hasLoadMoreError = true;
            emit(ProductsLoaded(products: allProducts, isSearching: false));
          } else {
            isLoadingMore = false;
            hasLoadMoreError = false;
            emit(ProductsError(error: error));
          }
        }
      },
      (products) {
        if (products.isEmpty) {
          hasMore = false;
        } else {
          allProducts.addAll(products);
          currentPage++;
        }
        if (!isClosed) {
          isLoading = false;
          isLoadingMore = false;
          hasLoadMoreError = false;
          emit(ProductsLoaded(products: allProducts, isSearching: false));
        }
      },
    );
  }

  Future<void> searchProducts({required String query}) async {
    if (isClosed) {
      return;
    }
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        isSearching = false;
        if (!isClosed) {
          emit(ProductsLoaded(products: allProducts, isSearching: false));
          return;
        }
      }

      isSearching = true;
      emit(ProductsLoading());
      final result = await homeRepository.searchProducts(query: query);
      result.fold(
        (error) {
          if (!isClosed) {
            emit(ProductsError(error: error));
          }
        },
        (products) {
          if (!isClosed) {
            emit(ProductsLoaded(products: products, isSearching: true));
          }
        },
      );
    });
  }

  // void retryLoadMore() {
  //   // hasLoadMoreError = false;
  //   getProducts();
  // }
}
