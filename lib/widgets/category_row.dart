import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/screens/edit_category.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/note_thumbnail.dart';

class CategoryRow extends StatelessWidget {
  final Category data;
  final double marginTop;
  final int animDelay;
  const CategoryRow(
      {super.key,
      required this.data,
      this.marginTop = 0,
      required this.animDelay});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(top: marginTop),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700),
                    )),
                    TextButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditCategory(category: data),
                          ),
                        )
                      },
                      child: const Icon(
                        Icons.edit_note,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
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
                                        categoryId: data.id,
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
                                          color: const Color.fromARGB(
                                              255, 51, 51, 51),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                              .map((note) => NoteThumbnail(
                                    note: note,
                                    categoryId: data.id,
                                    animDelay: data.notes.indexOf(note) * 300,
                                  ))
                              .toList()
                        ],
                      ),
                    )),
              ],
            ))
        .animate()
        .moveX(
            begin: 8,
            end: 0,
            delay: Duration(milliseconds: animDelay),
            duration: const Duration(milliseconds: 900))
        .fadeIn();
  }
}
