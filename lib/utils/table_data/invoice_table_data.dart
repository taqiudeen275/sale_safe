// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';
// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;



// class InvoiceTableData extends SqfEntityDBTableDataSource {
//   final InvoiceController invoiceController = Get.put(InvoiceController());

//   InvoiceTableData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? invoiceController.selectedID.add(id) : invoiceController.selectedID.remove(id);
//     selectedRow.value > 0 ? invoiceController.isSelected.value = true : invoiceController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => invoiceController.models;

//   Future<Invoice?> getById(int id) async {
//     return await Invoice().getById(id); // Assuming you have a getById method for Invoice
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Invoice? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Invoice"),
//       const Text("Are you sure you want to delete invoice for this invoice?"), // Assuming 'customerName' is a field in Invoice
//       [
//         FilledButton(
//           onPressed: () async {
//             await invoiceController.deleteModel(itemToDelete!);
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
//       const Text("Update Invoice"),
//       InvoiceForm(invoice: await getById(index)), // Assuming you have an InvoiceForm widget
//       [],
//     );
//   }
// }
