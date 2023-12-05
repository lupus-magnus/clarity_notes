import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function onChanged;
  final TextInputAction action;
  final void Function()? onEdittingComplete;
  const InputText({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = "Ex.: Reviews gastronômicas",
    this.action = TextInputAction.done,
    this.onEdittingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        textInputAction: action,
        onEditingComplete: () {
          if (onEdittingComplete != null) {
            onEdittingComplete!();
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          onChanged(value);
        },
        controller: controller,
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: Color.fromRGBO(60, 60, 60, 1)),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: const Color.fromRGBO(217, 217, 217, 1),
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
