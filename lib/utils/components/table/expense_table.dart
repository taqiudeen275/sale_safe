import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/utils.dart';

class ExpenseTable extends fluent_ui.StatefulWidget {
 

   ExpenseTable({Key? key}) : super(key: key);

  @override
  fluent_ui.State<ExpenseTable> createState() => _ExpenseTableState();
}

class _ExpenseTableState extends fluent_ui.State<ExpenseTable> {
  final ExpenseController expenseController = Get.put(ExpenseController());
 @override
  void initState() {
    expenseController.fetchByDate(DateTime.now());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => expenseController.isLoading.value ? const fluent_ui.ProgressRing(): Table(
        border: TableBorder.all(color: Colors.grey),
        columnWidths: const {
          0: FixedColumnWidth(150.0), // Name
          1: FixedColumnWidth(100.0), // Amount
          2: FlexColumnWidth(), // Description
          3: FixedColumnWidth(120.0), // Date
        },
        children: [
          const TableRow(
            decoration: BoxDecoration(color: Colors.grey),
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ...expenseController.expenseByDate.map(
            (expense) => TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(expense.name!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('GH¢ ${expense.amount!.toStringAsFixed(2)}'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(expense.description!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(formatDateTime(expense.date!)),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

