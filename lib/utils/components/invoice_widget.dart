import 'package:flutter/material.dart';
import 'package:sale_safe/model/model.dart';

class InvoiceWidget extends StatelessWidget {
  final String invoiceNumber;
  final String to;
  final DateTime invoiceDate;
  final List<Order> invoiceItems;

  const InvoiceWidget({
    Key? key,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.invoiceItems,
    required this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'AYAAME SMART ENTERPRISE',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'DEALER IN PLUMBING MATERIALS',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'ADDRESS: Box NL 3, Nalerigu',
            style: TextStyle(fontSize: 14.0),
          ),
          const Text(
            'LOCATION: Off the Sakogu Road, 200meters to the GAP filling station',
            style: TextStyle(fontSize: 14.0),
          ),
          const Text(
            'EMAIL: danaadum59@gmail.com',
            style: TextStyle(fontSize: 14.0),
          ),
          const Text(
            'CONTACT: 0548715659, 0247444811',
            style: TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'TO: ${to.toUpperCase()}',
                style: const TextStyle(fontSize: 14.0),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: const Text(
                  'INVOICE',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'INVOICE NO.: $invoiceNumber',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'DATE OF INVOICE: ${invoiceDate.day}/${invoiceDate.month}/${invoiceDate.year}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16.0),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(),
            columnWidths: const {
               0: FixedColumnWidth(30.0),
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
              ...invoiceItems.asMap().entries.map(
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
                          child: Text(item.plProduct!.price!.toStringAsFixed(2)),
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
                'GH¢ ${invoiceItems.fold<double>(0, (sum, item) => sum + item.amount!).toStringAsFixed(2)}',
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

class InvoiceItem {
  final String description;
  final int quantity;
  final double rate;
  final double total;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.rate,
    required this.total,
  });
}
