import 'package:fluent_ui/fluent_ui.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/utils.dart';

class ProductRecordTable extends StatelessWidget {
  final List<ProductRecord> records;

  const ProductRecordTable({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey),

      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            TableHeader(text: 'Action'),
            TableHeader(text: 'Current Quantity'),
            TableHeader(text: 'Previous Quantity'),
            TableHeader(text: 'Current Cost'),
            TableHeader(text: 'Previous Cost'),
            TableHeader(text: 'Current Price'),
            TableHeader(text: 'Previous Price'),
            TableHeader(text: 'Date'),
          ],
        ),
        ...records.map(
          (record) => TableRow(
            children: [
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.action ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.currentQuantity ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.previousQuantity ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.currentCost ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.previousCost ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.currentCurrent ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(record.previousPrice ?? "-"),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( record.date != null ? formatDateTime(record.date!) : "-"),
              )),
            ],
          ),
        ),
      ],
    );
  }
}


class TableHeader extends StatelessWidget {
  final String text;

  const TableHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
