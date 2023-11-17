import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  List<Note> get getRecentNotes {
    final categoryBox = Hive.box('category');
    final categoryMaps = categoryBox.values;
    final List<Category> categoryInstances = categoryMaps
        .map((categoryMap) => Category.fromMap(categoryMap))
        .toList();
    final List<Note> allNotes = categoryInstances
        .map(
          (category) => category.notes,
        )
        .toList()
        .expand((x) => x)
        .toList();
    allNotes.sort((noteA, noteB) => noteB.createdAt.compareTo(noteA.createdAt));
    final mostRecent5Notes = allNotes.take(5).toList();
    return mostRecent5Notes;
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
  addCategory(String name) async {
    final Category newCategory = Category.create(name: name);
    final categoryMap = newCategory.toMap();
    final categoryBox = await Hive.openBox('category');
    categoryBox.put(newCategory.id, categoryMap);
    await categoryBox.flush();
    final map = categoryBox.get(newCategory.id);
    final categoryFromBox = Category.fromMap(map);

    notifyListeners();
    return categoryFromBox;
  }

  updateCategory(String categoryId, {required String newName}) async {
    final categoryBox = await Hive.openBox('category');
    Map<dynamic, dynamic> selectedCategoryMap =
        await categoryBox.get(categoryId);
    categoryBox.put(categoryId, {...selectedCategoryMap, 'name': newName});
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
