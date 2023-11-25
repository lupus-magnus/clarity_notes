import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/category_view.dart';
import 'package:hello_world/screens/create_category_setup.dart';
import 'package:hello_world/screens/create_note_setup.dart';
import 'package:hello_world/themes/theme.dart';
import 'package:hello_world/widgets/bottom_navbar.dart';
import 'package:hello_world/widgets/category_note_thumb.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';

import 'package:hello_world/widgets/notebook_cover.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: Container(
          color: themeColors['background'],
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
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
                              .map((category) => NotebookCoverThumb(
                                    category: category,
                                  ))
                              .toList()),
                    ),
                    if (context
                        .watch<UserDataProvider>()
                        .getFavoriteCategories
                        .isNotEmpty)
                      const SizedBox(
                        height: 32,
                      ),
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
                      height: 226,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: context
                            .watch<UserDataProvider>()
                            .getRecentNotes
                            .map(
                              (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: CategoryNote(
                                    note: e.note,
                                    category: e.category,
                                    displayNotebookName: true,
                                  )),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
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
                              .map((e) => NotebookCover(category: e))
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

class NotebookCoverThumb extends StatelessWidget {
  final Category category;
  const NotebookCoverThumb({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isCoverLocal = !category.cover.contains('http');
    final int totalNotes = category.notes.length;

    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryView(category: category),
                  ),
                );
              },
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
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: isCoverLocal
                              ? AssetImage(category.cover) as ImageProvider
                              : NetworkImage(category.cover),
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
                                category.name,
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
                              fontSize: 12,
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
