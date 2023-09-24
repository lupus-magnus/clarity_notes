import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/note_thumbnail.dart';

class CategoryRow extends StatelessWidget {
  final Category data;
  final double marginTop;
  const CategoryRow({super.key, required this.data, this.marginTop = 64});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: marginTop),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.name,
              style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                child: SizedBox(
                  height: 128,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WriteView(
                                    noteCategory: data,
                                  ),
                                ),
                              );
                            },
                            child: Material(
                              color: Colors
                                  .white, // const Color.fromARGB(255, 51, 51, 51),
                              borderRadius: BorderRadius.circular(16),
                              child: Ink(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                    borderRadius: BorderRadius.circular(16)),
                                child: const Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  size: 48,
                                )),
                              ),
                            ),
                          )),
                      ...data.notes
                          .map((note) => NoteThumbnail(note: note))
                          .toList()
                    ],
                  ),
                )),
          ],
        ));
  }
}
