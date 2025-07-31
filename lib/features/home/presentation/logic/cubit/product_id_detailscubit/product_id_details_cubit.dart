import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/home/data/models/product_id_details_model/product_id_details_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_id_details_state.dart';

class ProductIdDetailsCubit extends Cubit<ProductIdDetailsState> {
  ProductIdDetailsCubit(this.homeRepo) : super(ProductIdDetailsInitial());

  final HomeRepository homeRepo;

  final Map<String, bool> hasFetchedMap = {};

  bool hasProductBeenFetched(String id) {
    return hasFetchedMap[id] == true;
  }

  Future<void> getProductDetails(String productId) async {
    if (isClosed || hasFetchedMap[productId] == true) {
      return;
    }

    emit(ProductIdDetailsLoading());

    final result = await homeRepo.getProductById(id: productId);

    result.fold(
      (error) {
        if (!isClosed) {
          emit(ProductIdDetailsError(error: error));
        }
      },
      (product) {
        hasFetchedMap[productId] = true;
        if (!isClosed) {
          emit(ProductIdDetailsLoaded(productIdDetailsModel: product));
        }
      },
    );
  }

  void resetFetchFlag(String productId) {
    hasFetchedMap[productId] = false;
  }
}
