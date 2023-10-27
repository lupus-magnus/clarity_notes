import 'package:flutter/material.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/button.dart';

class NoteViewOptions extends StatelessWidget {
  final Note note;
  final String categoryId;
  const NoteViewOptions(
      {super.key, required this.note, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Opções",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Button(
              text: 'EDITAR',
              outlined: true,
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WriteView(
                      note: note,
                      categoryId: categoryId,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Button(
              text: "COMPARTILHAR",
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ));
  }
}
