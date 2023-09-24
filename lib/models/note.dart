import 'package:uuid/uuid.dart';

class Note {
  String body;
  String? title;
  String id = const Uuid().v4();
  DateTime createdAt = DateTime.now();

  Note({required this.body, this.title});

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
}
