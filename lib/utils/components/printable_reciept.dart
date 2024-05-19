import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sale_safe/model/model.dart';

Widget buildRecieptPdf({
  required String receiptNumber,
  required String to,
  required DateTime receiptDate,
  required List<Order> receiptItems,
}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
           Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'AYAAME SMART ENTERPRISE',
                style: TextStyle(
                  fontSize: 30.0,
                  color: PdfColors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'DEALER IN PLUMBING MATERIALS',
                style: TextStyle(
                  fontSize: 16.0,
                  color: PdfColors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'ADDRESS: Box NL 3, Nalerigu',
                style: const TextStyle(fontSize: 12.0),
              ),
              Text(
                'LOCATION: Off the Sakogu Road, 200meters to the GAP filling station',
                style: const TextStyle(fontSize: 12.0),
              ),
              Text(
                'EMAIL: danaadum59@gmail.com',
                style: const TextStyle(fontSize: 12.0),
              ),
              Text(
                'CONTACT: 0548715659, 0247444811',
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
           SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'RECIEPT',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'TO: ${to.toUpperCase()}',
                    style:  TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'RECIEPT NO.: $receiptNumber',
                    style:  TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'DATE: ${receiptDate.day}/${receiptDate.month}/${receiptDate.year}',
                    style:  TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
           SizedBox(height: 25.0),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(),
            columnWidths: const {
              0: FixedColumnWidth(60.0),
              2: FixedColumnWidth(60.0),
            },
            children: [
               TableRow(
                decoration: const BoxDecoration(
                  color: PdfColors.grey,
                ),
                children: [
                  
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'NO.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ITEM DESCRIPTION',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'QTY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'RATE GH¢',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'TOTAL GH¢',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$index'),
                        ),
              
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.plProduct!.description!),
                        ),
                     
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.quantity.toString()),
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(item.plProduct!.price!.toStringAsFixed(2)),
                        ),
                    
                 Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.amount!.toStringAsFixed(2)),
                        ),
                    
                    ],
                  );
                },
              ),
            ],
          ),
           SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Text(
                'TOTAL: ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'GH¢ ${receiptItems.fold<double>(0, (sum, item) => sum + item.amount!).toStringAsFixed(2)}',
                style:  TextStyle(
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
