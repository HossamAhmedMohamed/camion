part of 'get_products_on_sale_cubit.dart';

sealed class GetProductsOnSaleState {}

final class GetProductsOnSaleInitial extends GetProductsOnSaleState {}

final class GetProductsOnSaleLoading extends GetProductsOnSaleState {}

final class GetProductsOnSaleSuccess extends GetProductsOnSaleState {
  List<AllProductModel> products;
  GetProductsOnSaleSuccess({required this.products});
}

final class GetProductsOnSaleError extends GetProductsOnSaleState {
  final ApiErrorModel error;
  GetProductsOnSaleError({required this.error});
}
