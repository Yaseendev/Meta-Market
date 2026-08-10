import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final String? Function(String? value)? validator;
  final String? initialValue;
  final int maxLines;
  const AppTextField({
    super.key,
    this.hint,
    this.label,
    this.keyboardType,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.initialValue,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIMetrics.radius),
        ),
        hintText: hint,
        labelText: label,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
