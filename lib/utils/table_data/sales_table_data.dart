// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';
// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;


// class SalesTableData extends SqfEntityDBTableDataSource {
//   final SaleController saleController = Get.put(SaleController()); // Assuming you already have or create a SaleController

//   SalesTableData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? saleController.selectedID.add(id) : saleController.selectedID.remove(id);
//     selectedRow.value > 0 ? saleController.isSelected.value = true : saleController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => saleController.models; // Assuming saleController.models holds a list of Sale objects

//   Future<Sale?> getById(int id) async {
//     return await Sale().getById(id); // Replace with your actual getById logic for Sale
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Sale? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Sale"),
//       const Text("Are you sure you want to delete sale for this Sale?"), // Assuming 'customerName' is a field in Sale
//       [
//         FilledButton(
//           onPressed: () async {
//             await saleController.deleteModel(itemToDelete!);
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
//       const Text("Update Sale"),
//       SaleForm(sale: await getById(index)), // Replace with your SaleForm widget
//       [],
//     );
//   }
// }
