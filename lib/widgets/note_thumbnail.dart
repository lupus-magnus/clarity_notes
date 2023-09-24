import 'package:flutter/material.dart';
import 'package:hello_world/models/note.dart';

class NoteThumbnail extends StatelessWidget {
  final Note note;
  const NoteThumbnail({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
          width: 128,
          height: 128,
          padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
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
                  "${note.title!}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 0.95),
                )
              ],
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  note.body,
                  style: TextStyle(
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
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  Text(
                    note.getFormattedDate(),
                    // note.createdAt.yMd().toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  )
                ],
              )
            ],
          )),
    );
  }
}
