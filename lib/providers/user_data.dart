import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserDataProvider extends ChangeNotifier {
  late List<Category> categories = [];
  UserDataProvider();

  List<Category> get getCategories {
    final categoryBox = Hive.box('category');
    final categoryMaps = categoryBox.values;
    final List<Category> categoryInstances = categoryMaps
        .map((categoryMap) => Category.fromMap(categoryMap))
        .toList();

    List<Category> categoriesWithNotesByDate =
        categoryInstances.map((category) {
      category.notes
          .sort((noteA, noteB) => noteB.createdAt.compareTo(noteA.createdAt));
      return Category(
          name: category.name, notes: category.notes, id: category.id);
    }).toList();
    categories = categoriesWithNotesByDate;

    return categoriesWithNotesByDate;
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

    final mappedUpdatedNote = updatedNote.toMap();

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
