class StoriesModel {
  String id;
  String title;
  String description;
  String mediaUrl;
  String mediaType;
  int duration;
  DateTime expiresAt;
  DateTime createdAt;
  bool isActive;

  StoriesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.mediaType,
    required this.duration,
    required this.expiresAt,
    required this.createdAt,
    required this.isActive,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) => StoriesModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    mediaUrl: json['mediaUrl'],
    mediaType: json['mediaType'],
    duration: json['duration'],
    expiresAt: DateTime.parse(json['expiresAt'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    isActive: json['isActive'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'mediaUrl': mediaUrl,
    'mediaType': mediaType,
    'duration': duration,
    'expiresAt': expiresAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'isActive': isActive,
  };
}
