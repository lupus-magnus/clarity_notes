import 'package:hello_world/models/note.dart';
import 'package:uuid/uuid.dart';

class Category {
  final String name;
  final String id;
  final List<Note> notes;
  final DateTime updatedAt;

  const Category(
      {required this.name,
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
      "updatedAt": updatedAt
    };

    return category;
  }

  factory Category.fromMap(Map<dynamic, dynamic> obj) {
    var formattedNotes = (obj['notes'] as List<dynamic>)
        .map((noteMap) => Note(
              id: noteMap['id'],
              title: noteMap['title'],
              body: noteMap['body'],
              createdAt: noteMap['createdAt'],
            ))
        .toList();
    Category category = Category(
        name: obj['name'],
        id: obj['id'],
        notes: formattedNotes,
        updatedAt: obj['updatedAt']);
    return category;
  }

  factory Category.create({required String name}) {
    String id = const Uuid().v4();
    Category category = Category(
      name: name,
      id: id,
      notes: [],
      updatedAt: DateTime.now(),
    );
    return category;
  }
}
