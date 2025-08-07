part of 'get_categories_cubit.dart';

sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}


final class GetCategoriesSuccess extends GetCategoriesState {
  final List<GeTCategoriesModel> categories;
  GetCategoriesSuccess({required this.categories});
}

final class GetCategoriesError extends GetCategoriesState {
  final ApiErrorModel error;
  GetCategoriesError({required this.error});
}
