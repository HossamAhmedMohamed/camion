class ShippingMethodModel {
  final int instanceId;
  final String methodId;
  final String title;
  final String cost;
  // final bool enabled;
  // final String description;

  ShippingMethodModel({
    required this.instanceId,
    required this.methodId,
    required this.title,
    required this.cost,
    // required this.enabled,
    // required this.description,
  });

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    return ShippingMethodModel(
      instanceId: json['instance_id'],
      methodId: json['method_id'],
      title: json['title'],
      cost: json['cost'] ?? '',
      // enabled: json['enabled'],
      // description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instance_id': instanceId,
      'method_id': methodId,
      'title': title,
      'cost': cost,
      // 'enabled': enabled,
      // 'description': description,
    };
  }
}
