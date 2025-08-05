part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<AllProductModel> products;
  final bool isSearching;

  ProductsLoaded({ required this.isSearching, required this.products});
}

final class ProductsError extends ProductsState {
  final ApiErrorModel error;

  ProductsError({required this.error});
}
