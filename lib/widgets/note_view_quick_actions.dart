import 'package:flutter/material.dart';
import 'package:hello_world/widgets/quick_action_button.dart';

class NoteViewQuickActions extends StatelessWidget {
  const NoteViewQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickActionButton(
            label: "Fixar",
            icon: const Icon(Icons.push_pin_outlined),
            onTap: () {},
          ),
          QuickActionButton(
            label: "Excluir",
            icon: const Icon(Icons.delete_outline),
            onTap: () {},
          ),
          QuickActionButton(
            label: "Editar",
            icon: const Icon(Icons.edit_outlined),
            onTap: () {},
          ),
          QuickActionButton(
            label: "Enviar",
            icon: const Icon(Icons.send_outlined),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
