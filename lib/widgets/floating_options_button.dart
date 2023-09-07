import 'package:flutter/material.dart';

class FloatingOptionsButton extends StatefulWidget {
  const FloatingOptionsButton({super.key});

  @override
  State<FloatingOptionsButton> createState() => _FloatingOptionsButtonState();
}

class _FloatingOptionsButtonState extends State<FloatingOptionsButton> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        // tooltip: 'Increment',
        child: isExpanded
            ? const Icon(
                Icons.add,
                size: 40,
              )
            : Icon(
                Icons.remove,
                size: 40,
              ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: CircleBorder(eccentricity: 0.0));
  }
}
