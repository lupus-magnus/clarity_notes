import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/quick_action_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

class NoteViewQuickActions extends StatelessWidget {
  final Note note;
  final Category category;
  const NoteViewQuickActions(
      {super.key, required this.note, required this.category});

  handleTapDelete(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Deseja excluir essa anotação?',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ao excluir, você nunca mais poderá recuperá-la.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  dataProvider.removeNote(
                      noteId: note.id, categoryId: category.id);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: const Text('Excluir anotação'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleTapEdit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WriteView(
          note: note,
          category: category,
        ),
      ),
    );
  }

  handleTapShare() {
    String text =
        "${note.getCreatedAtInFormattedDateTime()}\n\n${note.title}\n${note.body}";
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickActionButton(
            label: "Fixar",
            icon: const Icon(Icons.push_pin_outlined),
            onTap: () {
              dataProvider.togglePinNote(note.id, category.id);
            },
          ),
          QuickActionButton(
            label: "Excluir",
            icon: const Icon(Icons.delete_outline),
            onTap: () {
              handleTapDelete(context);
            },
          ),
          QuickActionButton(
            label: "Editar",
            icon: const Icon(Icons.edit_outlined),
            onTap: () {
              handleTapEdit(context);
            },
          ),
          QuickActionButton(
            label: "Enviar",
            icon: const Icon(Icons.send_outlined),
            onTap: handleTapShare,
          ),
        ],
      ),
    );
  }
}
