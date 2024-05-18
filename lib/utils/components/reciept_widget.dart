import 'package:flutter/material.dart';
import 'package:sale_safe/model/model.dart';

class ReceiptWidget extends StatelessWidget {
  final String receiptNumber;
  final String to;
  final DateTime receiptDate;
  final List<Order> receiptItems;

  const ReceiptWidget({
    Key? key,
    required this.receiptNumber,
    required this.receiptDate,
    required this.receiptItems,
    required this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'AYAAME SMART ENTERPRISE',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'DEALER IN PLUMBING MATERIALS',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'ADDRESS: Box NL 3, Nalerigu',
                style: TextStyle(fontSize: 14.0),
              ),
              Text(
                'LOCATION: Off the Sakogu Road, 200meters to the GAP filling station',
                style: TextStyle(fontSize: 14.0),
              ),
              Text(
                'EMAIL: danaadum59@gmail.com',
                style: TextStyle(fontSize: 14.0),
              ),
              Text(
                'CONTACT: 0548715659, 0247444811',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RECIEPT',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'TO: ${to.toUpperCase()}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'RECIEPT NO.: $receiptNumber',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'DATE: ${receiptDate.day}/${receiptDate.month}/${receiptDate.year}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(),
            columnWidths: const {
              0: FixedColumnWidth(60.0),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'NO.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'ITEM DESCRIPTION',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'QUANTITY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'RATE GH¢',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'TOTAL ¢',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...receiptItems.asMap().entries.map(
                (entry) {
                  final item = entry.value;
                  final index = entry.key + 1;
                  return TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$index'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.plProduct!.description!),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.quantity.toString()),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(item.plProduct!.price!.toStringAsFixed(2)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.amount!.toStringAsFixed(2)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'TOTAL: ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'GH¢ ${receiptItems.fold<double>(0, (sum, item) => sum + item.amount!).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
