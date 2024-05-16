// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';

// class PaymentMethodsDataData extends SqfEntityDBTableDataSource {
//   PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());

//   PaymentMethodsDataData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? paymentMethodController.selectedID.add(id) : paymentMethodController.selectedID.remove(id);
//     selectedRow.value > 0 ? paymentMethodController.isSelected.value = true : paymentMethodController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => paymentMethodController.models;

//   Future<PaymentMethod?> getById(int id) async {
//     return await PaymentMethod().getById(id);
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     PaymentMethod? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Payment Method"),
//       Text("Are you sure you want to delete ${itemToDelete!.name.toString()}"),
//       [
//         FilledButton(
//           onPressed: () async {
//             await paymentMethodController.deleteModel(itemToDelete);
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
//     super.onDeletePressed(index, context);
    
//   }

//   @override
//   Future<void> onEditPressed(index, context) async {
//     actionModal(
//       context,
//       const Text("Update Payment Method"),
//       PaymentMethodForm(paymentMethod: await getById(index)),
//       [],
//     );
//     super.onEditPressed(index, context);

//   }
// }