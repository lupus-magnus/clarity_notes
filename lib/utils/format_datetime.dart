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

String getFormattedDate(DateTime dateTime) {
  String formatedDate =
      "${dateTime.day} ${longFormatMonths[dateTime.month]!} ${dateTime.year}";
  return formatedDate;
}

String getFormattedDateTime(DateTime dateTime) {
  String result =
      "${getFormattedDate(dateTime)} | ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return result;
}
