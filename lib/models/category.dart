import 'package:hello_world/models/note.dart';
import 'package:uuid/uuid.dart';

List<Note> mocked = [
  Note(
      title: "Poema ruim (normal)",
      body: "Que saudades da minha terra querida..."),
  Note(
      title: "Anotações S1C2",
      body: "Hoje foi mais um dia de luta num mar de infinitos dias de luta"),
  Note(body: "Uma elegantissima nota sem titulo :D"),
];

class Category {
  String name;
  String id = const Uuid().v4();
  final List<Note> notes;
  Category({required this.name, List<Note>? notes}) : notes = notes ?? mocked;
}
