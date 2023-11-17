import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/note_view.dart';

import 'package:provider/provider.dart';

class NoteThumbnail extends StatelessWidget {
  final Note note;
  final Category category;
  final int animDelay;
  const NoteThumbnail({
    super.key,
    required this.note,
    required this.category,
    required this.animDelay,
  });

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteView(note: note, category: category),
            ),
          )
        },
        onDoubleTap: () => {dataProvider.togglePinNote(note.id, category.id)},
        onLongPress: () => showDialog<String>(
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
                    },
                    child: const Text('Excluir anotação'),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Material(
            child: Stack(
          children: [
            Ink(
                width: 128,
                height: 128,
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (note.title != null) ...[
                      Text(
                        note.title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 0.95),
                      )
                    ],
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        note.body,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.9),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        Text(
                          note.getCreatedAtFormattedDate(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                )),
            if (note.pinned)
              Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.push_pin, size: 12),
                  )).animate().moveY(begin: -4, end: 0, duration: 300.ms)
          ],
        )),
      ).animate(delay: Duration(milliseconds: animDelay)).then().shake(
          hz: 1,
          rotation: .03,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.ease),
    );
  }
}
