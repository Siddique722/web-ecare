import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: isPassword ?? false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText ?? " ",
        hintStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        // null  twxtfield error
        if (value == null || value.isEmpty) {
          //'Text('')
          return 'Please enter your $hintText';
        }
        if (hintText == 'Username' && !RegExp(r'^[a-zA-Z]').hasMatch(value)) {
          return 'Username must start with a letter';
        }
        if (hintText == 'Email' && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        if (hintText == 'Password' && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }

        if (hintText == 'Password' && !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&()])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
          return 'Password must contain letters, numbers, and special characters';
        }
        return null;
      },
    );
  }
}
