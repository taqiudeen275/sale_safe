// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';

// class OrdersDataData extends SqfEntityDBTableDataSource {
//   OrderController orderController = Get.put(OrderController());

//   OrdersDataData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value
//         ? orderController.selectedID.add(id)
//         : orderController.selectedID.remove(id);
//     selectedRow.value > 0
//         ? orderController.isSelected.value = true
//         : orderController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => orderController.models;
//   Future<Order?> getById(int id) async {
//     return await Order().getById(id);
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Order? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Order"),
//       const Text(
//           "Are you sure you want to delete this Order?"), // Replace with the appropriate field name
//       [
//         FilledButton(
//           onPressed: () async {
//             await orderController.deleteModel(itemToDelete!);
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
//       const Text("Update Order"),
//       OrderForm(order: await getById(index)),
//       [],
//     );
//     super.onEditPressed(index, context);
//     }
// }
