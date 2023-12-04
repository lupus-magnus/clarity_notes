import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteFromCategory {
  final Note note;
  final Category category;

  NoteFromCategory({required this.category, required this.note});
}

class IndexedNoteFromCategory {
  final Note note;
  final Category category;
  final int index;

  IndexedNoteFromCategory({
    required this.category,
    required this.note,
    required this.index,
  });
}

class IndexedCategory {
  final Category category;
  final int index;
  IndexedCategory({required this.category, required this.index});
}

class UserDataProvider extends ChangeNotifier {
  late List<Category> categories = [];
  late List<Category> favoriteCategories = [];

  UserDataProvider();

  List<Category> get getCategories {
    final categoryBox = Hive.box('category');
    final categoryMaps = categoryBox.values;
    final List<Category> categoryInstances = categoryMaps
        .map((categoryMap) => Category.fromMap(categoryMap))
        .toList();

    // Sort categories by date
    categoryInstances.sort((categoryA, categoryB) =>
        categoryB.updatedAt.compareTo(categoryA.updatedAt));

    // Sort notes by date
    List<Category> categoriesWithNotesByDate =
        categoryInstances.map((category) {
      category.notes
          .sort((noteA, noteB) => noteB.createdAt.compareTo(noteA.createdAt));
      List pinnedNotes = category.notes.where((note) => note.pinned).toList();
      List unpinnedNotes =
          category.notes.where((note) => !note.pinned).toList();

      return Category(
          name: category.name,
          notes: [...pinnedNotes, ...unpinnedNotes],
          id: category.id,
          cover: category.cover,
          description: category.description,
          favorite: category.favorite,
          updatedAt: category.updatedAt);
    }).toList();
    categories = categoriesWithNotesByDate;

    return categoriesWithNotesByDate;
  }

  List<IndexedCategory> get getIndexedCategories {
    final categories = getCategories;
    List<IndexedCategory> indexedCategories = [];

    for (int i = 0; i < categories.length; i++) {
      Category categoryInstance = categories[i];
      int index = i;

      final indexedCategory = IndexedCategory(
        category: categoryInstance,
        index: index,
      );
      indexedCategories.add(indexedCategory);
    }
    return indexedCategories;
  }

  List<Category> get getFavoriteCategories {
    final categoryBox = Hive.box('category');
    final categoryMaps = categoryBox.values;

    List<Category> categoryInstances = categoryMaps
        .map((categoryMap) => Category.fromMap(categoryMap))
        .toList();

    List<Category> favorites =
        categoryInstances.where((e) => e.favorite).toList();

    return favorites;
  }

  List<IndexedCategory> get getIndexedFavoriteCategories {
    // ignore: no_leading_underscores_for_local_identifiers
    final _categories = getFavoriteCategories;
    List<IndexedCategory> indexedFavoriteCategories = [];

    for (int i = 0; i < _categories.length; i++) {
      Category category = _categories[i];
      int index = i;

      final IndexedCategory indexedCategory = IndexedCategory(
        category: category,
        index: index,
      );

      indexedFavoriteCategories.add(indexedCategory);
    }
    return indexedFavoriteCategories;
  }

  List<NoteFromCategory> get getRecentNotes {
    final categoryBox = Hive.box('category');
    final categoryMaps = categoryBox.values;
    final List<Category> categoryInstances = categoryMaps
        .map((categoryMap) => Category.fromMap(categoryMap))
        .toList();

    final List<NoteFromCategory> notesFromCategories = categoryInstances
        .map((category) {
          final List<NoteFromCategory> notesFromCategory = [];
          for (var note in category.notes) {
            NoteFromCategory noteFromCategory =
                NoteFromCategory(category: category, note: note);
            notesFromCategory.add(noteFromCategory);
          }
          return notesFromCategory;
        })
        .toList()
        .expand((element) => element)
        .toList();

    notesFromCategories.sort(
        (itemA, itemB) => itemB.note.updatedAt.compareTo(itemA.note.updatedAt));

    return notesFromCategories;
  }

  List<IndexedNoteFromCategory> get getIndexedRecentNotes {
    final categorizedNotes = getRecentNotes;
    List<IndexedNoteFromCategory> indexedRecentNotes = [];

    for (int i = 0; i < categorizedNotes.length; i++) {
      NoteFromCategory categorizedNote = categorizedNotes[i];
      int index = i;

      final indexedRecentNote = IndexedNoteFromCategory(
        category: categorizedNote.category,
        note: categorizedNote.note,
        index: index,
      );

      indexedRecentNotes.add(indexedRecentNote);
    }
    return indexedRecentNotes;
  }

  Future<bool> toggleFavoriteCategory(String categoryId) async {
    final categoryBox = await Hive.openBox('category');
    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);

    categoryBox.put(categoryId,
        {...selectedCategoryMap, 'favorite': !selectedCategoryMap['favorite']});
    notifyListeners();
    return !selectedCategoryMap['favorite'];
  }

  // Categories CRUD
  addCategory(String name, {String? description, String? cover}) async {
    final Category newCategory =
        Category.create(name: name, description: description, cover: cover);
    final categoryMap = newCategory.toMap();
    final categoryBox = await Hive.openBox('category');
    categoryBox.put(newCategory.id, categoryMap);
    await categoryBox.flush();
    final map = categoryBox.get(newCategory.id);
    final categoryFromBox = Category.fromMap(map);

    notifyListeners();
    return categoryFromBox;
  }

  updateCategory(String categoryId,
      {required String newName,
      String? newCover,
      required String newDescription}) async {
    final categoryBox = await Hive.openBox('category');
    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);
    categoryBox.put(categoryId, {
      ...selectedCategoryMap,
      'name': newName,
      'cover': newCover,
      'description': newDescription
    });
  }

  removeCategory(String categoryId) async {
    final categoryBox = await Hive.openBox('category');

    categoryBox.delete(categoryId);
    notifyListeners();
  }

  // Notes CRUD
  addNoteToCategory({required String categoryId, required Note newNote}) async {
    final categoryBox = await Hive.openBox('category');

    Map<dynamic, dynamic> mappedNewNote = newNote.toMap();
    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);
    Map<String, dynamic> updatedCategoryMap = {
      ...selectedCategoryMap,
      "updatedAt": DateTime.now(),
      "notes": [...selectedCategoryMap['notes'], mappedNewNote]
    };

    categoryBox.put(categoryId, updatedCategoryMap);
    notifyListeners();
  }

  updateNote({required Note updatedNote, required String categoryId}) async {
    final categoryBox = await Hive.openBox('category');

    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);
    final notes = selectedCategoryMap['notes'] as List<dynamic>;

    final mappedUpdatedNote = {
      ...updatedNote.toMap(),
      'updatedAt': DateTime.now()
    };

    final updatedNotes = notes
        .map((mappedNote) =>
            mappedNote['id'] == updatedNote.id ? mappedUpdatedNote : mappedNote)
        .toList();

    Map<String, dynamic> updatedCategoryMap = {
      ...selectedCategoryMap,
      "notes": updatedNotes
    };

    categoryBox.put(categoryId, updatedCategoryMap);
    notifyListeners();
  }

  togglePinNote(String noteId, String categoryId) async {
    final categoryBox = await Hive.openBox('category');

    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);

    final categoryNotes = selectedCategoryMap['notes'] as List<dynamic>;
    final Map selectedNoteMap =
        categoryNotes.firstWhere((note) => note['id'] == noteId);

    final updatedNoteMap = {
      ...selectedNoteMap,
      "pinned": !selectedNoteMap['pinned']
    };

    final updatedCategoryNotes = categoryNotes
        .map((mappedNote) => mappedNote['id'] == updatedNoteMap['id']
            ? updatedNoteMap
            : mappedNote)
        .toList();

    Map<String, dynamic> updatedCategoryMap = {
      ...selectedCategoryMap,
      "notes": updatedCategoryNotes
    };
    await categoryBox.put(categoryId, updatedCategoryMap);
    notifyListeners();
    return updatedNoteMap['pinned'] as bool;
  }

  Future<bool> getPinStatus(String noteId, String categoryId) async {
    final categoryBox = await Hive.openBox('category');

    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);

    final categoryNotes = selectedCategoryMap['notes'] as List<dynamic>;
    final Map selectedNoteMap =
        categoryNotes.firstWhere((note) => note['id'] == noteId);
    return selectedNoteMap["pinned"] as bool;
  }

  removeNote({required String noteId, required String categoryId}) async {
    final categoryBox = await Hive.openBox('category');

    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);

    final notes = selectedCategoryMap['notes'] as List<dynamic>;
    final updatedNotes =
        notes.where((mappedNote) => mappedNote['id'] != noteId).toList();

    Map<String, dynamic> updatedCategoryMap = {
      ...selectedCategoryMap,
      "notes": updatedNotes
    };
    categoryBox.put(categoryId, updatedCategoryMap);

    notifyListeners();
  }
}
