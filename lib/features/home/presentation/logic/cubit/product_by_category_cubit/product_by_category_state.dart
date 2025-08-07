part of 'product_by_category_cubit.dart';

 
sealed class ProductByCategoryState {}

final class ProductByCategoryInitial extends ProductByCategoryState {}

final class ProductByCategoryLoading extends ProductByCategoryState {}

final class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<AllProductModel> products;
  ProductByCategoryLoaded({required this.products});
}

final class ProductByCategoryError extends ProductByCategoryState {
  final ApiErrorModel error;
  ProductByCategoryError({required this.error});
}
