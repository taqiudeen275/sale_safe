import '../model/model.dart';

List<Category> findCategoryContainingValue(String input, List<Category> data) {
  List<Category> resultTables = [];

  for (var record in data) {
    record.name!.contains(input) ? resultTables.add(record) : resultTables;
    // resultTables.add(table);
  }

  return resultTables;
}

List<Product> findProductContainingValue(String input, List<Product> data) {
  List<Product> resultTables = [];

  for (var record in data) {
    record.name!.toLowerCase().contains(input.toLowerCase()) | record.description!.toLowerCase().contains(input.toLowerCase())  ? resultTables.add(record) : resultTables;
    // resultTables.add(table);
  }

  return resultTables;
}

String formatDateTime(DateTime dateTime, {bool dateOnly = false}) {
  String formattedDate = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

  if (dateOnly) {
    return formattedDate;
  } else {
    String formattedTime = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return '$formattedDate $formattedTime';
  }
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}