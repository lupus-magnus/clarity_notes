import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function onChanged;
  const InputText({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = "Ex.: Reviews gastronômicas",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        controller: controller,
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: Color.fromRGBO(60, 60, 60, 1)),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color.fromRGBO(60, 60, 60, 1)),
        ),
      ),
    );
  }
}
