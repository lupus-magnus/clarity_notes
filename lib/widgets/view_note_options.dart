import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/widgets/heading.dart';

class NoteViewOptions extends StatelessWidget {
  final Note note;
  final Category category;
  const NoteViewOptions(
      {super.key, required this.note, required this.category});

  handleShareButtonPress(BuildContext context) async {
    // Copies content to clipboard
    Clipboard.setData(ClipboardData(
        text:
            "${note.getCreatedAtInFormattedDateTime()}\n\n*${note.title}*\n${note.body}"));

    // Generates toast for UX
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.fromLTRB(
            0, 0, 0, MediaQuery.of(context).size.height - 240),
        content: Container(
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading(text: "Sucesso!"),
                    Text(
                      "Sua anotação foi copiada.",
                    )
                  ],
                ))
            .animate()
            .moveY(
                begin: -20,
                end: 0,
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 300))
            .fadeIn()));
  }

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
                      category: category,
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
              onPressed: () {
                handleShareButtonPress(context);
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ));
  }
}
