import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';

import 'package:hello_world/models/note.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:hello_world/widgets/category_cover.dart';

import 'package:hello_world/widgets/custom_app_bar.dart';

import 'package:provider/provider.dart';

class WriteView extends StatelessWidget {
  final Category category;
  final Note? note;
  const WriteView({super.key, required this.category, this.note});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note?.title ?? '');
    TextEditingController bodyController =
        TextEditingController(text: note?.body ?? '');

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: Column(
          children: <Widget>[
            CategoryCover(pathOrUrl: category.cover),
            Expanded(
                child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Insira um titulo aqui (opcional)',
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: bodyController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pode escrever sem medo...',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                const SizedBox(height: 64)
              ],
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            UserDataProvider dataProvider =
                Provider.of<UserDataProvider>(context, listen: false);
            if (note == null) {
              dataProvider.addNoteToCategory(
                  categoryId: category.id,
                  newNote: Note.create(
                      body: bodyController.text, title: titleController.text));
            } else {
              dataProvider.updateNote(
                updatedNote: Note(
                    body: bodyController.text,
                    title: titleController.text,
                    id: note!.id,
                    createdAt: note!.createdAt,
                    updatedAt: note!.updatedAt),
                categoryId: category.id,
              );
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          },
          shape: const CircleBorder(eccentricity: 0.0),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: const Icon(
            Icons.check,
            size: 40,
          ),
        ));
  }
}
