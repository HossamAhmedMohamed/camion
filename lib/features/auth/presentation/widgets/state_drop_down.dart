import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' hide State;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateDropdownField extends StatefulWidget {
  final String? selectedCountry;
  final TextEditingController stateController;

  const StateDropdownField({
    super.key,
    required this.selectedCountry,
    required this.stateController,
  });

  @override
  State<StateDropdownField> createState() => _StateDropdownFieldState();
}

class _StateDropdownFieldState extends State<StateDropdownField> {
  // String? selectedState;
  List<String> states = [];

  @override
  void didUpdateWidget(covariant StateDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedCountry != oldWidget.selectedCountry) {
      _loadStates(widget.selectedCountry);
    }
  }

  Future<void> _loadStates(String? countryCode) async {
    if (countryCode == null) return;

    final statesList = await getStatesOfCountry(countryCode);
    setState(() {
      states = statesList.map((s) => s.name).toList();
      // selectedState = null;
      widget.stateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      maxLines: null,
      maxLength: null,
      readOnly: true,
      controller: widget.stateController,
      hintText: "State",
      suffixIcon: states.isEmpty
          ? const Icon(Icons.keyboard_arrow_down)
          : Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: DropdownButton<String>(
                // value: selectedState,
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      // selectedState = value;
                      widget.stateController.text = value;
                    });
                  }
                },
                items: states.map((state) {
                  return DropdownMenuItem(value: state, child: Text(state));
                }).toList(),
              ),
            ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your state';
        }
        return null;
      },
    );
  }
}
