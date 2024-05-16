// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';

// class PaymentDetailsDataData extends SqfEntityDBTableDataSource {
//   PaymentDetailController paymentDetailController = Get.put(PaymentDetailController());

//   PaymentDetailsDataData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? paymentDetailController.selectedID.add(id) : paymentDetailController.selectedID.remove(id);
//     selectedRow.value > 0 ? paymentDetailController.isSelected.value = true : paymentDetailController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => paymentDetailController.models;

//   Future<PaymentDetail?> getById(int id) async {
//     return await PaymentDetail().getById(id);
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     PaymentDetail? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Payment Detail"),
//       const Text("Are you sure you want to delete It"), // Replace with the appropriate field name
//       [
//         FilledButton(
//           onPressed: () async {
//             await paymentDetailController.deleteModel(itemToDelete!);
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
//       const Text("Update Payment Detail"),
//       PaymentDetailForm(paymentDetail: await getById(index)),
//       [],
//     );
//   }
// }