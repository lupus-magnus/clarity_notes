import 'package:flutter/material.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/create_category_setup.dart';
import 'package:hello_world/screens/create_note_setup.dart';
import 'package:hello_world/themes/theme.dart';
import 'package:hello_world/widgets/bottom_navbar.dart';
import 'package:hello_world/widgets/header.dart';

import 'package:hello_world/widgets/notebook_cover.dart';
import 'package:provider/provider.dart';

class HomeViewV3 extends StatelessWidget {
  const HomeViewV3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: themeColors['background'],
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Header(),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SectionHeading(text: "Notas recentes"),
                        TextButton(
                          onPressed: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CreateNoteSetup(),
                              ),
                            )
                          },
                          child: const Icon(
                            Icons.maps_ugc_rounded,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 130,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          NoteThumb(),
                          NoteThumb(),
                          NoteThumb(),
                          NoteThumb(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    if (context
                        .watch<UserDataProvider>()
                        .getFavoriteCategories
                        .isNotEmpty)
                      const SectionHeading(text: "Cadernos favoritos"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: context
                              .watch<UserDataProvider>()
                              .getFavoriteCategories
                              .map((e) => NotebookCoverThumb(
                                    cover: e.cover,
                                    name: e.name,
                                    totalNotes: e.notes.length,
                                  ))
                              .toList()),
                    ),
                    if (context
                        .watch<UserDataProvider>()
                        .getFavoriteCategories
                        .isNotEmpty)
                      const SizedBox(
                        height: 48,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SectionHeading(text: "Todos os cadernos"),
                        TextButton(
                          onPressed: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateCategorySetup(),
                              ),
                            )
                          },
                          child: const Icon(
                            Icons.maps_ugc_rounded,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: context
                              .watch<UserDataProvider>()
                              .getCategories
                              .map((e) => NotebookCover(
                                    cover: e.cover,
                                    name: e.name,
                                    description: e.description,
                                    totalNotes: e.notes.length,
                                    updatedAt: e.updatedAt,
                                    favorite: e.favorite,
                                    categoryId: e.id,
                                  ))
                              .toList()),
                    )
                  ],
                ),
              )
            ]),
          )),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String text;
  const SectionHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
          fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
    );
  }
}

class NoteThumb extends StatelessWidget {
  const NoteThumb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Container(
        height: 130,
        width: 92,
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
                color: Color.fromRGBO(0, 0, 0, 0.15),
                offset: Offset(4, 4))
          ],
        ),
        child: const Padding(
            padding: EdgeInsets.all(8),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      "S2C1 | Anotações",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing...",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.folder_open_outlined,
                                size: 12, color: Color.fromRGBO(51, 51, 51, 1)),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Categoria arrombada 1",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(51, 51, 51, 1)),
                            )
                          ],
                        )
                      ]),
                )
              ],
            )),
      ),
    );
  }
}

class NotebookCoverThumb extends StatelessWidget {
  final String name;
  final String cover;
  final int totalNotes;

  const NotebookCoverThumb({
    super.key,
    required this.cover,
    required this.name,
    required this.totalNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Stack(
          children: [
            Container(
              height: 130,
              width: 92,
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
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(4, 4))
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(cover),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Icon(Icons.file_copy_outlined,
                            size: 12, color: Color.fromRGBO(51, 51, 51, 1)),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          totalNotes == 0 ? 'Vazio' : totalNotes.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(51, 51, 51, 1)),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
