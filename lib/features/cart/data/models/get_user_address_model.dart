class GetUserAddressModel {
  final String city;
  final String email;
  final String phone;
  final String state;
  final String country;
  final String postcode;
  final String address1;
  final String address2;
  final String lastName;
  final String firstName;
  final ShippingOption shippingOption;
  final ShippingAddress shippingAddress;

  GetUserAddressModel({
    required this.city,
    required this.email,
    required this.phone,
    required this.state,
    required this.country,
    required this.postcode,
    required this.address1,
    required this.address2,
    required this.lastName,
    required this.firstName,
    required this.shippingOption,
    required this.shippingAddress,
  });

  factory GetUserAddressModel.fromJson(Map<String, dynamic> json) {
    return GetUserAddressModel(
      city: json['city'],
      email: json['email'],
      phone: json['phone'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'],
      address1: json['address_1'],
      address2: json['address_2'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      shippingOption: ShippingOption.fromJson(json['shipping_option']),
      shippingAddress: ShippingAddress.fromJson(json['shipping_address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "email": email,
      "phone": phone,
      "state": state,
      "country": country,
      "postcode": postcode,
      "address_1": address1,
      "address_2": address2,
      "last_name": lastName,
      "first_name": firstName,
      "shipping_option": shippingOption.toJson(),
      "shipping_address": shippingAddress.toJson(),
    };
  }
}

class ShippingOption {
  final String cost;
  final String methodId;
  final String methodTitle;

  ShippingOption({
    required this.cost,
    required this.methodId,
    required this.methodTitle,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) {
    return ShippingOption(
      cost: json['cost'],
      methodId: json['method_id'],
      methodTitle: json['method_title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cost": cost,
      "method_id": methodId,
      "method_title": methodTitle,
    };
  }
}

class ShippingAddress {
  final String city;
  final String email;
  final String phone;
  final String state;
  final String country;
  final String postcode;
  final String address1;
  final String address2;
  final String lastName;
  final String firstName;

  ShippingAddress({
    required this.city,
    required this.email,
    required this.phone,
    required this.state,
    required this.country,
    required this.postcode,
    required this.address1,
    required this.address2,
    required this.lastName,
    required this.firstName,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      city: json['city'],
      email: json['email'],
      phone: json['phone'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'],
      address1: json['address_1'],
      address2: json['address_2'],
      lastName: json['last_name'],
      firstName: json['first_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "email": email,
      "phone": phone,
      "state": state,
      "country": country,
      "postcode": postcode,
      "address_1": address1,
      "address_2": address2,
      "last_name": lastName,
      "first_name": firstName,
    };
  }
}
