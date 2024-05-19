import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;


class SuppliersTable extends StatefulWidget {
  const SuppliersTable({Key? key}) : super(key: key);

  @override
  State<SuppliersTable> createState() => _SuppliersTableState();
}

class _SuppliersTableState extends State<SuppliersTable> {
  final SupplierController supplierController = Get.put(SupplierController());

  @override
  void initState() {
    supplierController.fetchModels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
    () => supplierController.isLoading.value
        ? const fluent_ui.ProgressRing()
        : Table(
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
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(supplier.name!),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(supplier.email!),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(supplier.phone!),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(supplier.description!),
                    )),
                    TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(formatDateTime(supplier.date!)),
                        )),
                  ],
                ),
              ),
            ],
          ),
          ),
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
