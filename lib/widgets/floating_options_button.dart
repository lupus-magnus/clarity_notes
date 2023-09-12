import 'package:flutter/material.dart';
import 'package:hello_world/providers/menu_provider.dart';
import 'package:provider/provider.dart';

class FloatingOptionsButton extends StatefulWidget {
  const FloatingOptionsButton({super.key});

  @override
  State<FloatingOptionsButton> createState() => _FloatingOptionsButtonState();
}

class _FloatingOptionsButtonState extends State<FloatingOptionsButton> {
  bool isExpanded = false;
  late MenuProvider menuProvider;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
            if (isExpanded) {
              showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    menuProvider = context.watch<MenuProvider>();
                    return SizedBox(
                        height: 240,
                        child: Column(
                          children: [
                            Container(
                                height: 8, color: Color.fromARGB(128, 0, 0, 0)),
                            Expanded(
                                child: Container(
                                    color: Color.fromARGB(255, 51, 51, 51),
                                    child: menuProvider.getCurrentMenu()))
                          ],
                        ));
                  });
            } else {
              Navigator.pop(context);
            }
          });
        },
        child: isExpanded
            ? const Icon(
                Icons.remove,
                size: 40,
              )
            : Icon(
                Icons.add,
                size: 40,
              ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: CircleBorder(eccentricity: 0.0));
  }
}
