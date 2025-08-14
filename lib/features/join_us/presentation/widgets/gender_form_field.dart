import 'package:camion/features/join_us/presentation/widgets/selecting_male_or_female.dart';
import 'package:flutter/material.dart';

class GenderFormField extends FormField<String> {
  GenderFormField({
    super.key,
    super.onSaved,
    FormFieldValidator<String>? validator,
    super.initialValue,
  }) : super(
    validator: validator ?? (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a gender';
      }
      return null;
    },
    builder: (FormFieldState<String> state) {
      return Column(
        children: [
          SelectingMaleOrFemale(
            onGenderChanged: (gender) {
              state.didChange(gender);
            },
            errorText: state.errorText,
          ),
        ],
      );
    },
  );
}