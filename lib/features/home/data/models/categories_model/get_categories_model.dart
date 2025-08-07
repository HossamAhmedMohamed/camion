// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camion/features/home/data/models/categories_model/category_image.dart';

class GeTCategoriesModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int parent;
  final int count;
  final CategoryImage? image;
  final int reviewCount;
  final String permalink;
  GeTCategoriesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.parent,
    required this.count,
    this.image,
    required this.reviewCount,
    required this.permalink,
  });

  factory GeTCategoriesModel.fromJson(Map<String, dynamic> json) {
    return GeTCategoriesModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      parent: json['parent'],
      count: json['count'],
      image: json['image'] != null ? CategoryImage.fromJson(json['image']) : null,
      reviewCount: json['review_count'],
      permalink: json['permalink'],
    );
  }

}


