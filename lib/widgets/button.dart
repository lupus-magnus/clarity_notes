import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool outlined;
  final String text;
  final void Function() onPressed;
  final Icon? icon;
  const Button(
      {super.key,
      this.outlined = false,
      this.icon,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return CustomOutlinedButton(
        text: text,
        icon: icon,
        onPressed: onPressed,
      );
    } else {
      return CustomButton(
        text: text,
        onPressed: onPressed,
        icon: icon,
      );
    }
  }
}

class CustomOutlinedButton extends Button {
  const CustomOutlinedButton(
      {super.key, required super.text, super.icon, required super.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              const SizedBox(
                width: 8,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          )),
    );
  }
}

class CustomButton extends Button {
  const CustomButton(
      {super.key,
      required super.text,
      required super.onPressed,
      required super.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
