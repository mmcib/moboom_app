import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.maxLines,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final int? maxLines;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autocorrect: false,
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
