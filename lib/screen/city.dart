import 'package:flutter/material.dart';

class CityInputField extends StatelessWidget {
  final TextEditingController controller;

 const CityInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Enter city name',
      ),
    );
  }
}
