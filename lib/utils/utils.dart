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

