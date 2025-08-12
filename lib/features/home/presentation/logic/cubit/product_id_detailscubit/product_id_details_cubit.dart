import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/cached_services/product_id_cache_service.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_id_details_state.dart';

class ProductIdDetailsCubit extends Cubit<ProductIdDetailsState> {
  ProductIdDetailsCubit(this.homeRepo, this.cacheService)
    : super(ProductIdDetailsInitial());

  final HomeRepository homeRepo;
  final ProductCacheService cacheService;
  // final Map<String, bool> _loadingStates = {};

  Future<void> getProductDetails(
    String productId, {
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    // if (!forceRefresh) {
    //   final cachedProduct = cacheService.getCachedProduct(productId);
    //   if (cachedProduct != null) {
    //     emit(ProductIdDetailsLoaded(productIdDetailsModel: cachedProduct));
    //     return;
    //   }
    // }

    // if (_loadingStates[productId] == true) return;

    // _loadingStates[productId] = true;
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(ProductIdDetailsLoading());

    final result = await homeRepo.getProductById(id: productId, token: token!);
    // _loadingStates[productId] = false;

    if (isClosed) return;

    result.fold((error) => emit(ProductIdDetailsError(error: error)), (
      product,
    ) {
      // cacheService.cacheProduct(productId, product);
      emit(ProductIdDetailsLoaded(productIdDetailsModel: product));
    });
  }
}
