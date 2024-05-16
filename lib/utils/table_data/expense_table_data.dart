// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';
// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;


// class ExpenseTableData extends SqfEntityDBTableDataSource {
//   final ExpenseController expenseController = Get.put(ExpenseController());

//   ExpenseTableData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? expenseController.selectedID.add(id) : expenseController.selectedID.remove(id);
//     selectedRow.value > 0 ? expenseController.isSelected.value = true : expenseController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => expenseController.models;

//   Future<Expense?> getById(int id) async {
//     return await Expense().getById(id); // Assuming you have a getById method for Expense
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Expense? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Expense"),
//       Text("Are you sure you want to delete expense for ${itemToDelete!.name}?"), // Assuming 'name' is a field in Expense
//       [
//         FilledButton(
//           onPressed: () async {
            
//             await expenseController.deleteModel(itemToDelete);
//             Navigator.pop(context);
//           },
//           child: const Text("Yes"),
//         ),
//         fluent_ui.Button(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           text: const Text("No"),
//         ),
//       ],
//     );
//   }

//   @override
//   Future<void> onEditPressed(index, context) async {
//     actionModal(
//       context,
//       const Text("Update Expense"),
//       ExpenseForm(expense: await getById(index)), // Assuming you have an ExpenseForm widget
//       [],
//     );
//   }
// }
