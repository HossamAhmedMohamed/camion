// address_cubit.dart
 

import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressState.initial());

  void updateAddress({
    required String city,
    required String district,
    required String street,
    required String buildingNumber,
    required String apartmentNumber,
    required String type,
  }) {
    emit(state.copyWith(
      city: city,
      district: district,
      street: street,
      buildingNumber: buildingNumber,
      apartmentNumber: apartmentNumber,
      type: type,
      hasAddress: true,
    ));
  }

  String get formattedAddress {
    if (!state.hasAddress) {
      return "لم يتم تحديد عنوانك بعد";
    }
    return "${state.city}، ${state.district}، ${state.street}";
  }
}

class AddressState {
  final String city;
  final String district;
  final String street;
  final String buildingNumber;
  final String apartmentNumber;
  final String type; // شقة أو مكتب
  final bool hasAddress;

  AddressState({
    required this.city,
    required this.district,
    required this.street,
    required this.buildingNumber,
    required this.apartmentNumber,
    required this.type,
    required this.hasAddress,
  });

  factory AddressState.initial() {
    return AddressState(
      city: '',
      district: '',
      street: '',
      buildingNumber: '',
      apartmentNumber: '',
      type: 'شقة',
      hasAddress: false,
    );
  }

  AddressState copyWith({
    String? city,
    String? district,
    String? street,
    String? buildingNumber,
    String? apartmentNumber,
    String? type,
    bool? hasAddress,
  }) {
    return AddressState(
      city: city ?? this.city,
      district: district ?? this.district,
      street: street ?? this.street,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      type: type ?? this.type,
      hasAddress: hasAddress ?? this.hasAddress,
    );
  }
}