// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';

// class PaymentTableData extends SqfEntityDBTableDataSource {
//   final PaymentController paymentController = Get.put(PaymentController());

//   PaymentTableData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? paymentController.selectedID.add(id) : paymentController.selectedID.remove(id);
//     selectedRow.value > 0 ? paymentController.isSelected.value = true : paymentController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => paymentController.models;

//   Future<Payment?> getById(int id) async {
//     return await Payment().getById(id); // Assuming you have a getById method for Payment
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Payment? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Payment"),
//       const Text("Are you sure you want to delete payment for this payment?"), // Assuming 'name' is a field in Payment
//       [
//         FilledButton(
//           onPressed: () async {
//             await paymentController.deleteModel(itemToDelete!);
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
//       const Text("Update Payment"),
//       PaymentForm(payment: await getById(index)), // Assuming you have a PaymentForm widget
//       [],
//     );
//   }
// }
