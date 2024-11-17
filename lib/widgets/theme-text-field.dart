import 'package:flutter/material.dart';

class LightDarktextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText; // Make labelText nullable
  final TextInputType keyboardType;

  const LightDarktextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText, // Initialize labelText as nullable
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        validator: (value) {
          // If labelText is null or the controller's text is empty, skip validation
          if (labelText == null || controller.text.isEmpty) {
            return null;
          }
          // Proceed with validation if labelText is not null and the controller's text is not empty
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          if (keyboardType == TextInputType.phone && value.length != 10) {
            return 'Phone number must be exactly 10 digits';
          }
          return null;
        },
        onChanged: (value) {
          if (labelText != null && controller.text.isNotEmpty) {
            final form = Form.of(context);
            form?.validate(); // Trigger validation when the text field changes
          }
        },
      ),
    );
  }
}
