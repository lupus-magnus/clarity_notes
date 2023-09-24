import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';

import 'package:hello_world/widgets/template_cover.dart';
import 'package:provider/provider.dart';

class WriteView extends StatelessWidget {
  final Category noteCategory;
  const WriteView({super.key, required this.noteCategory});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    return Scaffold(
        body: Column(
          children: <Widget>[
            const TemplateCover(
              renderBacklink: true,
            ),
            Expanded(
                child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 48,
                        ),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Seu titulo aqui',
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: bodyController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pode escrever sem medo...',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                SizedBox(height: 64)
              ],
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            UserDataProvider dataProvider =
                Provider.of<UserDataProvider>(context, listen: false);
            dataProvider.addNoteToCategory(
                categoryId: noteCategory.id,
                newNote: Note(
                    body: bodyController.text, title: titleController.text));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          },
          shape: CircleBorder(eccentricity: 0.0),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.check,
            size: 40,
          ),

          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
