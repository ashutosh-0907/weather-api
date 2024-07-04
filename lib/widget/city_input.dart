import 'package:flutter/material.dart';

class _CityField extends StatefulWidget {
  const _CityField({super.key});

  @override
  State<_CityField> createState() => __CityFieldState();
}

class __CityFieldState extends State<_CityField> {
  
  final TextEditingController textEditingController = TextEditingController();

  final border = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 2.0,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      home: Scaffold(
        ),
      );
  }
}

class CityInput extends StatelessWidget {
  const CityInput({
    super.key,
    required this.textEditingController,
    required this.border,
  });

  final TextEditingController textEditingController;
  final OutlineInputBorder border;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
                style:  const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter your city',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  prefixIconColor: Colors.black87,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                  suffixIcon: const Icon(Icons.search_off_rounded)
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ));
  }
}
