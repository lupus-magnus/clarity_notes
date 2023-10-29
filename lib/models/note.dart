import 'package:uuid/uuid.dart';

class Note {
  final String id;

  final String? title;
  final String body;

  final DateTime createdAt;
  final DateTime updatedAt;

  final bool pinned;

  Note({
    required this.body,
    this.title,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.pinned = false,
  });

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

  String getCreatedAtFormattedDate() {
    String formatedDate =
        "${createdAt.day} ${longFormatMonths[createdAt.month]!} ${createdAt.year}";
    return formatedDate;
  }

  String getUpdatedAtFormattedDate() {
    String formatedDate =
        "${updatedAt.day} ${longFormatMonths[updatedAt.month]!} ${updatedAt.year}";
    return formatedDate;
  }

  String getCreatedAtInFormattedDateTime() {
    String result =
        "${getCreatedAtFormattedDate()} | ${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}";

    return result;
  }

  String getUpdatedAtInFormattedDateTime() {
    String result =
        "${getUpdatedAtFormattedDate()} | ${updatedAt.hour.toString().padLeft(2, '0')}:${updatedAt.minute.toString().padLeft(2, '0')}";

    return result;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> note = {
      "id": id,
      "title": title,
      "body": body,
      "createdAt": createdAt,
      "pinned": pinned,
      "updatedAt": updatedAt,
    };
    return note;
  }

  factory Note.fromMap(Map<dynamic, dynamic> obj) {
    Note note = Note(
        id: obj['id'],
        title: obj['title'],
        body: obj['body'],
        createdAt: obj['createdAt'],
        updatedAt: obj['updatedAt'],
        pinned: obj['pinned']);

    return note;
  }

  factory Note.create({required String body, String title = ''}) {
    String id = const Uuid().v4();
    DateTime createdAt = DateTime.now();

    Note note = Note(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
      updatedAt: createdAt,
    );
    return note;
  }
}
