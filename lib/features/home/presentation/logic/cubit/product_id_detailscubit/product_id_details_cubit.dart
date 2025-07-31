import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/services/cached_services/product_id_cache_service.dart';
import 'package:camion/features/home/data/models/product_id_details_model/product_id_details_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_id_details_state.dart';

class ProductIdDetailsCubit extends Cubit<ProductIdDetailsState> {
  ProductIdDetailsCubit(this.homeRepo, this.cacheService)
    : super(ProductIdDetailsInitial());

  final HomeRepository homeRepo;
  final ProductCacheService cacheService;
  final Map<String, bool> _loadingStates = {};

  Future<void> getProductDetails(
    String productId, {
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    if (!forceRefresh) {
      final cachedProduct = cacheService.getCachedProduct(productId);
      if (cachedProduct != null) {
        emit(ProductIdDetailsLoaded(productIdDetailsModel: cachedProduct));
        return;
      }
    }

    if (_loadingStates[productId] == true) return;

    _loadingStates[productId] = true;
    emit(ProductIdDetailsLoading());

    final result = await homeRepo.getProductById(id: productId);
    _loadingStates[productId] = false;

    if (isClosed) return;

    result.fold((error) => emit(ProductIdDetailsError(error: error)), (
      product,
    ) {
      cacheService.cacheProduct(productId, product);
      emit(ProductIdDetailsLoaded(productIdDetailsModel: product));
    });
  }
}
