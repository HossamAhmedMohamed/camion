class ShippingMethodModel {
  final int instanceId;
  final String methodId;
  final String title;
  final double cost;
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
      cost: (json['cost'] as num).toDouble(),
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
