import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  final String label;
  final String validation;
  final double radius;
  final TextInputType type;
  final TextEditingController controller;
  final bool isPassword;

  const MyForm({
    Key? key,
    required this.label,
    required this.validation,
    required this.type,
    required this.controller,
    this.radius = 15.0,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      validator: (value) {
        if(value!.isEmpty) {
          return validation;
        }

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        labelText: label,
      ),
    );
  }
}
