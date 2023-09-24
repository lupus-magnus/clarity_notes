import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/models/note.dart';

class UserDataProvider extends ChangeNotifier {
  final List<Category> _categories = [
    Category(name: "Anotações do Bimestre"),
    Category(name: "Minhas letras de música")
  ];
  UserDataProvider();

  List<Category> get getCategories {
    return _categories;
  }

  addCategory(String name) {
    Category newCategory = Category(name: name, notes: []);
    _categories.insert(0, newCategory);
    notifyListeners();
  }

  addNoteToCategory({required String categoryId, required Note newNote}) {
    Category selectedCategory =
        _categories.firstWhere((element) => element.id == categoryId);
    selectedCategory.notes.insert(0, newNote);
    notifyListeners();
  }
}
