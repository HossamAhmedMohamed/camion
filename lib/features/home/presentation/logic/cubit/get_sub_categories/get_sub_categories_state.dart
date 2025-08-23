part of 'get_sub_categories_cubit.dart';

sealed class GetSubCategoriesState {}

final class GetSubCategoriesInitial extends GetSubCategoriesState {}

final class GetSubCategoriesLoading extends GetSubCategoriesState {}

final class GetSubCategoriesSuccess extends GetSubCategoriesState {
  final List<GeTCategoriesModel> subCategories;
  GetSubCategoriesSuccess({required this.subCategories});
}

final class GetSubCategoriesError extends GetSubCategoriesState {
  final ApiErrorModel error;
  GetSubCategoriesError({required this.error});
}
