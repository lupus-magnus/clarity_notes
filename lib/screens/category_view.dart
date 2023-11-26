import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/edit_category.dart';
import 'package:hello_world/screens/write_view.dart';

import 'package:hello_world/utils/show_delete_category_dialog.dart';
import 'package:hello_world/widgets/bottom_navbar.dart';
import 'package:hello_world/widgets/category_cover.dart';
import 'package:hello_world/widgets/category_note_thumb.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import 'package:hello_world/widgets/quick_action_button.dart';

class CategoryView extends StatefulWidget {
  final Category category;
  const CategoryView({super.key, required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.category.favorite;
  }

  void handleSetState(bool newIsFavorite) {
    setState(() {
      isFavorite = newIsFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryCover(pathOrUrl: widget.category.cover),
            CategoryQuickActions(
              isFavorite: isFavorite,
              category: widget.category,
              handleSetState: handleSetState,
            ),
            CategoryTitleRow(category: widget.category),
            widget.category.notes.isEmpty
                ? Column(
                    children: [
                      Lottie.asset("assets/animations/new_category.json",
                          frameRate: FrameRate(20), fit: BoxFit.cover),
                      const Icon(Icons.info_outline),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          "Caderno vazio. Pressione ESCREVER para adicionar sua primeira nota.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                : NotesGridSection(
                    notes: widget.category.notes,
                    category: widget.category,
                  )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class CategoryQuickActions extends StatelessWidget {
  final bool isFavorite;
  final Category category;
  final void Function(bool) handleSetState;
  const CategoryQuickActions(
      {super.key,
      required this.isFavorite,
      required this.category,
      required this.handleSetState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuickActionButton(
                label: isFavorite ? "FAVORITADO" : "FAVORITAR",
                icon:
                    Icon(isFavorite ? Icons.star : Icons.star_border_outlined),
                onTap: () async {
                  bool newIsFavorite = await context
                      .read<UserDataProvider>()
                      .toggleFavoriteCategory(category.id);
                  handleSetState(newIsFavorite);
                }),
            QuickActionButton(
                label: "EXCLUIR",
                icon: const Icon(Icons.delete_outline),
                onTap: () {
                  showDeleteCategoryDialog(category.id, context);
                }),
            QuickActionButton(
                label: "EDITAR",
                icon: const Icon(Icons.edit_outlined),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditCategory(category: category),
                    ),
                  );
                }),
            QuickActionButton(
                label: "ESCREVER",
                icon: const Icon(Icons.maps_ugc_rounded),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WriteView(category: category),
                    ),
                  );
                }),
          ]),
    );
  }
}

class CategoryTitleRow extends StatelessWidget {
  final Category category;
  const CategoryTitleRow({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          const Icon(Icons.folder_open),
          const SizedBox(width: 8),
          SizedBox(
            width: 280,
            child: Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      )
          .animate()
          .fadeIn(delay: 300.ms, duration: 300.ms)
          .moveX(begin: 24, end: 0, duration: 300.ms),
    );
  }
}

class IndexedNote {
  final Note note;
  final int index;

  IndexedNote({required this.index, required this.note});
}

class NotesGridSection extends StatelessWidget {
  final List<Note> notes;
  final Category category;
  const NotesGridSection(
      {super.key, required this.notes, required this.category});

  List<IndexedNote> get getIndexedNotes {
    List<IndexedNote> indexedNotes = [];

    for (int i = 0; i < notes.length; i++) {
      Note note = notes[i];
      int index = i;

      final IndexedNote indexedNote = IndexedNote(
        index: index,
        note: note,
      );

      indexedNotes.add(indexedNote);
    }
    return indexedNotes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(16),
      child: notes.length > 1
          ? Center(
              child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: getIndexedNotes
                      .map((e) => CategoryNote(
                            note: e.note,
                            category: category,
                            delayMs: 300 + 150 * e.index,
                          ))
                      .toList()))
          : Row(
              children: notes
                  .map((e) => CategoryNote(note: e, category: category))
                  .toList()),
    );
  }
}
