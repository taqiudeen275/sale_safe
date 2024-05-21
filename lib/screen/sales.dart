import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/forms/invoice_form.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/invoice_widget.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/order_pick.dart';
import 'package:sale_safe/utils/components/printable_invoice.dart';
import 'package:sale_safe/utils/components/printable_reciept.dart';
import 'package:sale_safe/utils/components/reciept_widget.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final ProductController productController = Get.put(ProductController());
  final SaleController salesController = Get.put(SaleController());
  final InvoiceController invoiceController = Get.put(InvoiceController());
  final ExpenseController expenseController = Get.put(ExpenseController());

  final OrderController orderController = Get.put(OrderController());
  RxBool isCredit = false.obs;
  DateTime? selectedDate;
  RxDouble revenue = 0.0.obs;


  @override
  void initState() {
    salesController.fetchByDate(DateTime.now());
    expenseController.fetchByDate(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
        revenue.value = salesController.salesByDate.fold(
            0.0, (previousValue, element) => previousValue + element.amount!) -
        expenseController.expenseByDate.fold(
            0.0, (previousValue, element) => previousValue + element.amount!);
      return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("View Sales By Date: "),
                          const SizedBox(width: 10),
                          DatePicker(
                            selected: selectedDate,
                            onChanged: (time) => setState(() {
                              selectedDate = time;
                              salesController.fetchByDate(selectedDate!);
                            }),
                          ),
                          const SizedBox(width: 10),
                          FilledButton(
                              child: const Text("Today"),
                              onPressed: () {
                                setState(() {
                                  selectedDate = DateTime.now();
                                  salesController.fetchByDate(selectedDate!);
                                });
                              })
                        ],
                      ),
                      RecordSale(
                          isCredit: isCredit,
                          productController: productController,
                          salesController: salesController,
                          orderController: orderController),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate != null
                            ? "${formatDateTime(selectedDate!, dateOnly: true) == formatDateTime(DateTime.now(), dateOnly: true) ? 'TODAY\'S' : formatDateTime(selectedDate!, dateOnly: true)} Sales"
                            : "TODAY'S SALES",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                              "TOTAL REVENUE GH¢  ${revenue.value.toStringAsFixed(2)}",
                              style:  TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                  color:revenue.value.isNegative? Colors.red :Colors.successPrimaryColor),
                            )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...salesController.salesByDate.map((sale) => Expander(
                            header: Text(
                                'Sales at  ${sale.date?.toLocal().toString()}'),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommandBar(
                                      overflowBehavior:
                                          CommandBarOverflowBehavior.noWrap,
                                      primaryItems: [
                                        if (sale.plInvoices!.any((element) =>
                                            element.salesId == sale.id))
                                          CommandBarBuilderItem(
                                            builder: (context, mode, w) =>
                                                Tooltip(
                                              message:
                                                  "View and Print invoice of this sale",
                                              child: w,
                                            ),
                                            wrappedItem: CommandBarButton(
                                              icon: const Icon(
                                                  FluentIcons.receipt_check),
                                              label: const Text('View Invoice'),
                                              onPressed: () async {
                                                Invoice? invoice =
                                                    await invoiceController
                                                        .getBySaleId(sale.id!);
                                                // ignore: use_build_context_synchronously
                                                bigActionModal(
                                                    context,
                                                    const Text("Invoice"),
                                                    SingleChildScrollView(
                                                        child: InvoiceWidget(
                                                            invoiceNumber: invoice!
                                                                .invoice_number
                                                                .toString(),
                                                            invoiceDate:
                                                                invoice.date!,
                                                            to: invoice
                                                                .customer_name!,
                                                            invoiceItems: sale
                                                                .plOrders!)),
                                                    [
                                                      FilledButton(
                                                        child:
                                                            const Text("Print"),
                                                        onPressed: () async {
                                                          final doc =
                                                              pw.Document();

                                                          doc.addPage(
                                                            pw.Page(
                                                              pageFormat:
                                                                  PdfPageFormat
                                                                      .a4,
                                                              build: (pw.Context
                                                                  context) {
                                                                return buildInvoicePdf(
                                                                    invoiceNumber: invoice
                                                                        .invoice_number
                                                                        .toString(),
                                                                    invoiceDate:
                                                                        invoice
                                                                            .date!,
                                                                    to: invoice
                                                                        .customer_name!,
                                                                    invoiceItems:
                                                                        sale.plOrders!);
                                                              },
                                                            ),
                                                          );

                                                          await Printing.sharePdf(
                                                              bytes: await doc
                                                                  .save(),
                                                              filename:
                                                                  'Ayaame Smart Enterprise ${invoice.invoice_number}_invoice.pdf');
                                                        },
                                                      ),
                                                      Button(
                                                          child: const Text(
                                                              "Close"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ]);
                                              },
                                            ),
                                          ),
                                        if (!sale.plInvoices!.any((element) =>
                                            element.salesId == sale.id))
                                          CommandBarBuilderItem(
                                            builder: (context, mode, w) =>
                                                Tooltip(
                                              message:
                                                  "Create a an invoice for this sale",
                                              child: w,
                                            ),
                                            wrappedItem: CommandBarButton(
                                              icon:
                                                  const Icon(FluentIcons.view),
                                              label:
                                                  const Text('Create Invoice'),
                                              onPressed: () {
                                                actionModal(
                                                    context,
                                                    const Text("Add Invoice"),
                                                    InvoiceAdd(
                                                      sale: sale,
                                                    ),
                                                    [
                                                      Button(
                                                          child: const Text(
                                                              "Close"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ]);
                                              },
                                            ),
                                          ),
                                        CommandBarBuilderItem(
                                          builder: (context, mode, w) =>
                                              Tooltip(
                                            message:
                                                "View and Print receipt of this sale",
                                            child: w,
                                          ),
                                          wrappedItem: CommandBarButton(
                                            icon: const Icon(FluentIcons.view),
                                            label: const Text('View Reciept'),
                                            onPressed:
                                                !sale.plInvoices!.any(
                                                        (element) =>
                                                            element.salesId ==
                                                            sale.id)
                                                    ? null
                                                    : () async {
                                                        Invoice? invoice =
                                                            await invoiceController
                                                                .getBySaleId(
                                                                    sale.id!);
                                                        // ignore: use_build_context_synchronously
                                                        bigActionModal(
                                                            context,
                                                            const Text(
                                                                "Reciept"),
                                                            SingleChildScrollView(
                                                                child: ReceiptWidget(
                                                                    receiptNumber:
                                                                        invoice!
                                                                            .invoice_number
                                                                            .toString(),
                                                                    receiptDate:
                                                                        invoice
                                                                            .date!,
                                                                    to: invoice
                                                                        .customer_name!,
                                                                    receiptItems:
                                                                        sale.plOrders!)),
                                                            [
                                                              FilledButton(
                                                                  child: const Text(
                                                                      "Print"),
                                                                  onPressed:
                                                                      () async {
                                                                    final doc =
                                                                        pw.Document();

                                                                    doc.addPage(
                                                                      pw.Page(
                                                                        pageFormat:
                                                                            PdfPageFormat.a4,
                                                                        build: (pw
                                                                            .Context
                                                                            context) {
                                                                          return buildRecieptPdf(
                                                                              receiptNumber: invoice.invoice_number.toString(),
                                                                              receiptDate: invoice.date!,
                                                                              to: invoice.customer_name!,
                                                                              receiptItems: sale.plOrders!);
                                                                        },
                                                                      ),
                                                                    );

                                                                    await Printing.sharePdf(
                                                                        bytes: await doc
                                                                            .save(),
                                                                        filename:
                                                                            'Ayaame Smart Enterprise ${invoice.invoice_number}_reciept.pdf');
                                                                  }),
                                                              Button(
                                                                  child: const Text(
                                                                      "Close"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  })
                                                            ]);
                                                      },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Table(
                                      columnWidths: const {
                                        2: FixedColumnWidth(90.0),
                                        3: FixedColumnWidth(90.0),
                                        4: FixedColumnWidth(120.0),
                                      },
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[50]),
                                            children: const [
                                              TableCell(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Name',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Description',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Price GH¢',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Quantity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Total GH¢',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                        ...sale.plOrders!.map((order) =>
                                            TableRow(children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      '${order.plProduct!.name}'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      '${order.plProduct!.description}'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(order
                                                      .plProduct!.price!
                                                      .toStringAsFixed(2)),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      Text('${order.quantity}'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(order.amount!
                                                      .toStringAsFixed(2)),
                                                ),
                                              ),
                                            ]))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Total : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "GH¢ ${sale.amount!.toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ]),
              ),
            ),
          ],
        );});
  }
}

class RecordSale extends StatelessWidget {
  const RecordSale({
    super.key,
    required this.isCredit,
    required this.productController,
    required this.salesController,
    required this.orderController,
  });

  final RxBool isCredit;
  final ProductController productController;
  final SaleController salesController;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          bigActionModal(context, const Text("Add Sale"), const OrderPick(), [
            Button(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Obx(() => Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FilledButton(
                          onPressed: productController.selectedItems.isEmpty
                              ? null
                              : () async {
                                  await saleItemAdd();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                          child: const Text("Record Sale")),
                    ),
                  ],
                )),
          ]);
        },
        child: const Text("Record Sale"));
  }

  Future<void> saleItemAdd() async {
    int saleId = await salesController.addGetModel(Sale(
        isCredit: isCredit.value,
        date: DateTime.now(),
        amount: orderController.selectedItems
            .fold(0.0, (sum, product) => sum! + product.amount!)));

    await orderController.onItemSelectedSave(saleId);

    productController.onProuctSale(
        productController.selectedItems,
        orderController.selectedItems
            .map((element) => element.quantity ?? 0)
            .toList());
    await productController.fetchModels();
    await salesController.fetchByDate(DateTime.now());
  }
}
