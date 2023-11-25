import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/screens/note_view.dart';
import 'package:hello_world/themes/theme.dart';
import 'package:hello_world/utils/format_datetime.dart';

class CategoryNote extends StatelessWidget {
  final Note note;
  final Category category;
  final bool displayNotebookName;
  const CategoryNote({
    super.key,
    required this.note,
    required this.category,
    this.displayNotebookName = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteView(note: note, category: category),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 226,
            width: 160,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3.0,
                  blurRadius: 3.0,
                  offset: Offset(3, 3),
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note.title != null)
                    Text(
                      note.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  if (note.title != null) const SizedBox(height: 8),
                  Text(
                    note.body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: displayNotebookName ? 6 : 7,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 16,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (displayNotebookName)
                    Row(
                      children: [
                        Icon(Icons.menu_book_rounded,
                            size: 12, color: themeColors['mutedText']),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            category.name,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: themeColors['mutedText']),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          size: 12, color: themeColors['mutedText']),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        getFormattedDateTime(note.createdAt),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: themeColors['mutedText']),
                      )
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
