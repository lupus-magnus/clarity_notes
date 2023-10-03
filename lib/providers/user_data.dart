import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';

class UserDataProvider extends ChangeNotifier {
  late List<Category> _categories = [
    Category(name: "Anotações do Bimestre"),
    Category(name: "Minhas letras de música")
  ];
  UserDataProvider();

  List<Category> get getCategories {
    return _categories;
  }

  // Categories CRUD
  addCategory(String name) {
    Category newCategory = Category(name: name, notes: []);
    _categories.insert(0, newCategory);
    notifyListeners();
  }

  removeCategory(String categoryId) {
    try {
      Category categoryToDelete =
          _categories.firstWhere((element) => element.id == categoryId);
      _categories.remove(categoryToDelete);
      notifyListeners();
      // ignore: empty_catches
    } catch (err) {}
  }

  // Notes CRUD

  addNoteToCategory({required String categoryId, required Note newNote}) {
    Category selectedCategory =
        _categories.firstWhere((element) => element.id == categoryId);
    selectedCategory.notes.insert(0, newNote);
    notifyListeners();
  }

  updateNote(
      {required String noteId,
      required String categoryId,
      required String newTitle,
      required String newBody}) {
    Note updatedNote = Note(body: newBody, title: newTitle);
    Category selectedCategory =
        _categories.firstWhere((category) => category.id == categoryId);
    Category updatedCategory = Category(
        name: selectedCategory.name,
        notes: selectedCategory.notes
            .map((note) => noteId != note.id ? note : updatedNote)
            .toList());
    _categories = _categories
        .map((category) =>
            category.id != categoryId ? category : updatedCategory)
        .toList();

    notifyListeners();
  }

  removeNote({required String noteId, required String categoryId}) {
    Category selectedCategory =
        _categories.firstWhere((category) => category.id == categoryId);
    selectedCategory.notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }
}
