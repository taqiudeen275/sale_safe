import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/utils.dart';

class SuppliersTable extends StatelessWidget {
  SuppliersTable({Key? key}) : super(key: key);

  final SupplierController supplierController = Get.put(SupplierController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Obx(() => supplierController.models.isEmpty ? const ProgressRing():
       Table(
        // defaultColumnWidth: const IntrinsicColumnWidth(),
        border: TableBorder.all(color: Colors.grey),
        columnWidths: const {
          0: FlexColumnWidth(), // Name
          1: FlexColumnWidth(), // Amount
          2: FlexColumnWidth(), // Description
          3: FlexColumnWidth(), // Date
          4: FixedColumnWidth(120.0), // Date
        },
        children: [
          const TableRow(
            decoration: BoxDecoration(color: Colors.grey),
            children: [
              TableHeader(text: 'Name'),
              TableHeader(text: 'Email'),
              TableHeader(text: 'Phone'),
              TableHeader(text: 'Description'),
              TableHeader(text: 'Date'),
            ],
          ),
          ...supplierController.models.map(
            (supplier) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCell(child: Text(supplier.name!)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCell(child: Text(supplier.email!)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCell(child: Text(supplier.phone!)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCell(child: Text(supplier.description!)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCell(child: Text(formatDateTime(supplier.date!))),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
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
