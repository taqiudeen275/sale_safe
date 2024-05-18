import '../model/model.dart';

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


String generateInvoiceNumber() {
  final now = DateTime.now();
  final year = now.year.toString().substring(2); // Get the last two digits of the year
  final month = now.month.toString().padLeft(2, '0'); // Month with leading zero if needed
  final day = now.day.toString().padLeft(2, '0'); // Day with leading zero if needed
  final hour = now.hour.toString().padLeft(2, '0'); // Hour with leading zero if needed
  final minute = now.minute.toString().padLeft(2, '0'); // Minute with leading zero if needed
  final second = now.second.toString().padLeft(2, '0'); // Second with leading zero if needed

  final invoiceNumber = '$year$month$day$hour$minute$second';
  return invoiceNumber;
}