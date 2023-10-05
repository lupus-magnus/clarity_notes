import 'package:uuid/uuid.dart';

class Note {
  final String id;

  final String? title;
  final String body;

  final DateTime createdAt;

  Note({
    required this.body,
    this.title,
    required this.id,
    required this.createdAt,
  });

  String getFormattedDate() {
    Map<int, String> longFormatMonths = {
      1: "Jan",
      2: "Fev",
      3: "Mar",
      4: "Abr",
      5: "Mai",
      6: "Jun",
      7: "Jul",
      8: "Ago",
      9: "Set",
      10: "Out",
      11: "Nov",
      12: "Dez",
    };

    String formatedDate =
        "${createdAt.day} ${longFormatMonths[createdAt.month]!} ${createdAt.year}";
    return formatedDate;
  }

  String getFormattedDateTime() {
    String result =
        "${getFormattedDate()} | ${createdAt.hour}:${createdAt.minute}";

    return result;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> note = {
      "id": id,
      "title": title,
      "body": body,
      "createdAt": createdAt
    };
    return note;
  }

  factory Note.fromMap(Map<dynamic, dynamic> obj) {
    Note note = Note(
        id: obj['id'],
        title: obj['title'],
        body: obj['body'],
        createdAt: obj['createdAt']);
    return note;
  }

  factory Note.create({required String body, String title = ''}) {
    String id = const Uuid().v4();
    DateTime createdAt = DateTime.now();

    Note note = Note(id: id, title: title, body: body, createdAt: createdAt);
    return note;
  }
}
