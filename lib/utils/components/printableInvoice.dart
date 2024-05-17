import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sale_safe/model/model.dart';


pw.Widget buildInvoicePdf({
  required String invoiceNumber,
  required String to,
  required DateTime invoiceDate,
  required List<Order> invoiceItems,
}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(16.0),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          'AYAAME SMART ENTERPRISE',
          style: pw.TextStyle(
            fontSize: 30.0,
            color: PdfColors.blueAccent,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8.0),
        pw.Text(
          'DEALER IN PLUMBING MATERIALS',
          style: pw.TextStyle(
            fontSize: 16.0,
            color: PdfColors.deepOrange,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 16.0),
        pw.Text(
          'ADDRESS: Box NL 3, Nalerigu',
          style: pw.TextStyle(fontSize: 14.0),
        ),
        pw.Text(
          'LOCATION: Off the Sakogu Road, 200 meters to the GAP filling station',
          style: pw.TextStyle(fontSize: 14.0),
        ),
        pw.Text(
          'EMAIL: danaadum59@gmail.com',
          style: pw.TextStyle(fontSize: 14.0),
        ),
        pw.Text(
          'CONTACT: 0548715659, 0247444811',
          style: pw.TextStyle(fontSize: 14.0),
        ),
        pw.SizedBox(height: 16.0),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'TO: ${to.toUpperCase()}',
              style: pw.TextStyle(fontSize: 16.0, fontWeight: pw.FontWeight.bold),
            ),
            pw.Container(
              color: PdfColors.black,
              padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: pw.Text(
                'INVOICE',
                style: pw.TextStyle(
                  fontSize: 20.0,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ),
            pw.Column(
              children: [
                pw.Text(
                  'INVOICE NO.: $invoiceNumber',
                  style: pw.TextStyle(fontSize: 16.0, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'DATE OF INVOICE: ${invoiceDate.day}/${invoiceDate.month}/${invoiceDate.year}',
                  style: pw.TextStyle(fontSize: 16.0, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 16.0),
        pw.Table(
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FixedColumnWidth(60.0),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(
                color: PdfColors.grey,
              ),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'NO.',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'ITEM DESCRIPTION',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'QUANTITY',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'RATE GH¢',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'TOTAL ¢',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...invoiceItems.asMap().entries.map((entry) {
              final item = entry.value;
              final index = entry.key + 1;
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text('$index'),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(item.plProduct!.description!),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(item.quantity.toString()),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(item.plProduct!.price!.toStringAsFixed(2)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(item.amount!.toStringAsFixed(2)),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 16.0),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              'TOTAL: ',
              style: pw.TextStyle(fontSize: 18.0, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              'GH¢ ${invoiceItems.fold<double>(0, (sum, item) => sum + item.amount!).toStringAsFixed(2)}',
              style: pw.TextStyle(fontSize: 18.0, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

// final doc =
//                                                                 pw.Document();
//                                                             doc.addPage(pw.Page(
//                                                                 pageFormat:
//                                                                     PdfPageFormat
//                                                                         .a4,
//                                                                 build: (pw
//                                                                     .Context
//                                                                     context) {
//                                                                   return buildInvoicePdf(
//                                                                       invoiceNumber: invoice
//                                                                           .invoice_number
//                                                                           .toString(),
//                                                                       invoiceDate:
//                                                                           invoice
//                                                                               .date!,
//                                                                       to: invoice
//                                                                           .customer_name!,
//                                                                       invoiceItems:
//                                                                           sale.plOrders!);
//                                                                 }));
//                                                             final output =
//                                                                 await getExternalStorageDirectory();
//                                                             final file = File(
//                                                                 "${output!.path}/invoice_${sale.id}.pdf");
//                                                             await file
//                                                                 .writeAsBytes(
//                                                                     await doc
//                                                                         .save());
//                                                             print(
//                                                                 "PDF saved to ${file.path}");