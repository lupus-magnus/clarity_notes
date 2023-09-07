import 'package:flutter/material.dart';

// const NoteThumb.color = RGBA(255,51,51,51)

class CategoryRow extends StatelessWidget {
  final String name;

  const CategoryRow({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 64.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                child: SizedBox(
                  height: 128,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color.fromARGB(255, 51, 51, 51),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color.fromARGB(255, 51, 51, 51),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color.fromARGB(255, 51, 51, 51),
                            )),
                      )
                    ],
                    scrollDirection: Axis.horizontal,
                  ),
                )),
          ],
        ));
  }
}
