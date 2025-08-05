import 'dart:async';

import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/models/product_model/product_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.homeRepository) : super(ProductsInitial());

  final HomeRepository homeRepository;

  int skip = 0;
  final int limit = 6;
  bool hasMore = true;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasLoadMoreError = false;

  List<AllProductModel> allProducts = [];

  bool isSearching = false;

  Timer? _debounce;

  Future<void> getProducts() async {
    if (isClosed) return;
    emit(ProductsLoading());
    final result = await homeRepository.getProducts();
    result.fold(
      (error) {
        if (!isClosed) {
          emit(ProductsError(error: error));
        }
      },
      (products) {
        allProducts.addAll(products);
        if (!isClosed) {
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

  void retryLoadMore() {
    // hasLoadMoreError = false;
    getProducts();
  }
}
