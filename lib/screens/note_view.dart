import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';

import 'package:hello_world/widgets/bottom_navbar.dart';
import 'package:hello_world/widgets/category_cover.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';

import 'package:hello_world/widgets/note_view_quick_actions.dart';

class NoteView extends StatefulWidget {
  final Note note;
  final Category category;

  const NoteView({super.key, required this.note, required this.category});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool isPinned = false;

  @override
  void initState() {
    super.initState();
    isPinned = widget.note.pinned;
  }

  handleSetIsPinned(bool updatedIsPinned) {
    setState(() {
      isPinned = updatedIsPinned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: Container(
        color: const Color.fromRGBO(237, 237, 237, 1),
        child: Column(
          children: <Widget>[
            CategoryCover(pathOrUrl: widget.category.cover),
            const SizedBox(
              height: 24,
            ),
            Expanded(
                child: ListView(
              children: [
                NoteViewQuickActions(
                  note: widget.note,
                  category: widget.category,
                  handleSetIsPinned: handleSetIsPinned,
                  isPinned: isPinned,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Caderno",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    widget.category.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Criado em",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.note.getCreatedAtInFormattedDateTime(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.edit_calendar_outlined,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Atualizado em",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.note.getUpdatedAtInFormattedDateTime(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ],
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
                              begin: 1,
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
                        if (isPinned)
                          const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.push_pin_outlined,
                                      size: 18,
                                      color: Color.fromRGBO(51, 51, 51, 1)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Anotação fixada",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(51, 51, 51, 1)),
                                  )
                                ],
                              )).animate(delay: 2300.ms).fadeIn(),
                        Text(
                          widget.note.title ?? '',
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
                        Container(
                                constraints: const BoxConstraints(minHeight: 240),
                                child: Text(
                                  widget.note.body,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ))
                            .animate()
                            .fadeIn(
                                delay: const Duration(milliseconds: 1500),
                                begin: 0,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut)
                            .moveY(begin: 24, end: 0),
                      ],
                    )),
              ],
            ))
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
