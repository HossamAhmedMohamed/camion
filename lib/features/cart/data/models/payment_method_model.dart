// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camion/core/utils/app_images.dart';

class PaymentMethodModel {
  final String title;
  final String image;
  PaymentMethodModel({required this.title, required this.image});
}

List<PaymentMethodModel> paymentMethods = [
  PaymentMethodModel(title: "بطاقة ائتمان", image: Assets.imagesImageVisa),
  PaymentMethodModel(title: "STC PAY", image: Assets.imagesImageStc),
  PaymentMethodModel(title: "نقدي", image: Assets.imagesImageNakdy),
];
