import 'package:flutter/material.dart';
import 'package:hello_world/widgets/note_thumbnail.dart';

// const NoteThumb.color = RGBA(255,51,51,51)

class CategoryRow extends StatelessWidget {
  final String name;
  final int marginTop;

  const CategoryRow({super.key, required this.name, this.marginTop = 64});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: marginTop.toDouble()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                child: SizedBox(
                  height: 128,
                  child: ListView(
                    children: [
                      NoteThumbnail(),
                      NoteThumbnail(),
                      NoteThumbnail()
                    ],
                    scrollDirection: Axis.horizontal,
                  ),
                )),
          ],
        ));
  }
}
