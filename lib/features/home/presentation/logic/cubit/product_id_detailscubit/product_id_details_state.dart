part of 'product_id_details_cubit.dart';

sealed class ProductIdDetailsState {}

final class ProductIdDetailsInitial extends ProductIdDetailsState {}

final class ProductIdDetailsLoading extends ProductIdDetailsState {}

final class ProductIdDetailsLoaded extends ProductIdDetailsState {
  final AllProductModel productIdDetailsModel;
  ProductIdDetailsLoaded({required this.productIdDetailsModel});
}

final class ProductIdDetailsError extends ProductIdDetailsState {
  final ApiErrorModel error;
  ProductIdDetailsError({required this.error});
}
