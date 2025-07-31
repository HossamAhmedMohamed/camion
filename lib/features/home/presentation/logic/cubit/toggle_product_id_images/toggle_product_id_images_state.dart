part of 'toggle_product_id_images_cubit.dart';

sealed class ToggleProductIdImagesState {
  int index;

  ToggleProductIdImagesState({required this.index});
}

final class ToggleProductIdImagesInitial extends ToggleProductIdImagesState {
  ToggleProductIdImagesInitial() : super(index: 0);
}

final class ToggleProductIdImagesChanged extends ToggleProductIdImagesState {
  ToggleProductIdImagesChanged({required super.index});
}
