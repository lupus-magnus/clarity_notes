import 'package:flutter/material.dart';
import 'package:hello_world/screens/create_category_setup.dart';
import 'package:hello_world/screens/create_note_setup.dart';
import 'package:hello_world/widgets/button.dart';

class HomeViewOptions extends StatelessWidget {
  const HomeViewOptions({super.key});

  @override
  Widget build(BuildContext context) {
    void handleCreateCategory() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CreateCategorySetup()),
      );
    }

    void handleCreateNote() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CreateNoteSetup()),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Button(
              text: "CRIAR CADERNO",
              icon: const Icon(Icons.library_books_outlined),
              outlined: true,
              onPressed: handleCreateCategory),
          const SizedBox(height: 8),
          Button(
              text: "ESCREVER ANOTAÇÃO",
              icon: const Icon(Icons.edit_outlined),
              onPressed: handleCreateNote)
        ],
      ),
    );
  }
}
