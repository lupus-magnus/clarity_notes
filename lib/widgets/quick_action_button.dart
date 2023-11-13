import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final Function onTap;

  const QuickActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(237, 237, 237, 1),
      child: InkWell(
        onTap: () {
          // Adicione a lógica desejada para o clique do botão aqui
          onTap();
        },
        child: Column(
          children: [
            Ink(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 3),
                    spreadRadius: 3.0,
                    blurRadius: 3.0,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
              child: Center(child: icon),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
