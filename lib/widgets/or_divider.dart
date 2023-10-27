import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 48, 0, 48),
      child: Row(children: [
        Expanded(
          child: Divider(),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Text(
              "ou",
              style: TextStyle(fontSize: 18),
            )),
        Expanded(
          child: Divider(),
        )
      ]),
    );
  }
}
