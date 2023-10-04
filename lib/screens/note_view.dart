import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/screens/write_view.dart';

import 'package:hello_world/widgets/template_cover.dart';

class NoteView extends StatelessWidget {
  final Note note;
  final String categoryId;

  const NoteView({super.key, required this.note, required this.categoryId});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 22,
                          ),
                          Text(
                            // "15SET2023 | Sáb. 14:23",
                            note.getFormattedDateTime(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ],
                      )
                          .animate()
                          .fade(
                              delay: const Duration(milliseconds: 600),
                              begin: 0,
                              end: 1)
                          .slideY(
                            duration: const Duration(milliseconds: 600),
                            begin: -2,
                            end: 0,
                          ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(48, 16, 48, 16),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      )
                          .animate()
                          .scaleX(
                              delay: const Duration(milliseconds: 900),
                              begin: 0,
                              end: 1.2,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut)
                          .then()
                        ..scaleX(
                            begin: 1,
                            end: 0.7,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut),
                      Text(
                        note.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                        textAlign: TextAlign.left,
                      )
                          .animate()
                          .fadeIn(
                              delay: const Duration(milliseconds: 2000),
                              begin: 0,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut)
                          .moveX(begin: -8, end: 0),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        note.body,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                          .animate()
                          .fadeIn(
                              delay: const Duration(milliseconds: 1500),
                              begin: 0,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut)
                          .moveY(begin: 24, end: 0),
                    ],
                  )),
              const SizedBox(height: 64)
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
        shape: const CircleBorder(eccentricity: 0.0),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.edit,
          size: 40,
        ),
      ),
    );
  }
}
