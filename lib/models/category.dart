import 'dart:math';

import 'package:hello_world/models/note.dart';
import 'package:uuid/uuid.dart';

class Category {
  final String name;
  final String id;

  final String description;
  final bool favorite;
  final String cover;

  final List<Note> notes;
  final DateTime updatedAt;

  const Category(
      {required this.name,
      required this.description,
      required this.favorite,
      required this.cover,
      required this.notes,
      required this.id,
      required this.updatedAt});

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> mappedNotes =
        notes.map((note) => note.toMap()).toList();
    Map<String, dynamic> category = {
      "id": id,
      "name": name,
      "notes": mappedNotes,
      "updatedAt": updatedAt,
      "cover": cover,
      "favorite": favorite,
      "description": description,
    };

    return category;
  }

  factory Category.fromMap(Map<dynamic, dynamic> obj) {
    var formattedNotes = (obj['notes'] as List<dynamic>)
        .map(
          (noteMap) => Note(
              id: noteMap['id'],
              title: noteMap['title'],
              body: noteMap['body'],
              createdAt: noteMap['createdAt'],
              pinned: noteMap['pinned'],
              updatedAt: noteMap['updatedAt']),
        )
        .toList();
    Category category = Category(
        name: obj['name'],
        cover: obj['cover'],
        description: obj['description'],
        favorite: obj['favorite'],
        id: obj['id'],
        notes: formattedNotes,
        updatedAt: obj['updatedAt']);
    return category;
  }

  factory Category.create({
    required String name,
    String? description,
    String? cover,
  }) {
    String id = const Uuid().v4();

    String getRandomCover() {
      int random = Random().nextInt(7) + 1;
      String randomCoverPath = 'assets/textures/${random.toString()}.jpg';
      return randomCoverPath;
    }

    String defaultDescription = 'Mais um caderno de anotações.';
    Category category = Category(
        name: name,
        id: id,
        notes: [],
        updatedAt: DateTime.now(),
        description: description ?? defaultDescription,
        cover: cover ?? getRandomCover(),
        favorite: false);
    return category;
  }
}
