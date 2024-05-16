// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';

// class SuppliersDataData extends SqfEntityDBTableDataSource {
//   SupplierController supplierController = Get.put(SupplierController());

//   SuppliersDataData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? supplierController.selectedID.add(id) : supplierController.selectedID.remove(id);
//     selectedRow.value > 0 ? supplierController.isSelected.value = true : supplierController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => supplierController.models;

//   Future<Supplier?> getById(int id) async {
//     return await Supplier().getById(id);
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Supplier? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Supplier"),
//       Text("Are you sure you want to delete ${itemToDelete!.name.toString()}"),
//       [
//         FilledButton(
//           onPressed: () async {
//             await supplierController.deleteModel(itemToDelete);
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
//       const Text("Update Supplier"),
//       SupplierForm(supplier: await getById(index)),
//       [],
//     );
//      super.onEditPressed(index, context);
//   }
// }