import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Button extends StatelessWidget {
  final bool outlined;
  final bool disabled;
  final bool highlight;
  final String text;
  final void Function()? onPressed;
  final Icon? icon;

  const Button(
      {super.key,
      this.outlined = false,
      this.disabled = false,
      this.highlight = false,
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
    } else if (highlight) {
      return CustomHighlightedButton(
        text: text,
        onPressed: onPressed,
        icon: icon,
        disabled: disabled,
      );
    } else {
      return CustomButton(
        text: text,
        onPressed: onPressed,
        icon: icon,
        disabled: disabled,
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
          onPressed: disabled ? null : onPressed,
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
      required super.icon,
      required super.disabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: disabled
            ? disabledStyle
            : ButtonStyle(
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

class CustomHighlightedButton extends Button {
  const CustomHighlightedButton(
      {super.key,
      required super.text,
      required super.onPressed,
      required super.icon,
      required super.disabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: disabled
            ? disabledStyle
            : ButtonStyle(
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
      )
          .animate(
            onPlay: (controller) => controller.repeat(),
          )
          .shimmer(duration: 1000.ms, delay: 3000.ms),
    );
  }
}

ButtonStyle disabledStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(
        const Color.fromRGBO(137, 137, 137, 1)),
    backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromRGBO(192, 192, 192, 1)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))));
