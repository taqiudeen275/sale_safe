// import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sale_safe/model/model.dart';
// import 'package:sale_safe/utils/base_table.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sqfentity_gen/sqfentity_gen.dart';

// class LeadsDataData extends SqfEntityDBTableDataSource {
//   LeadController leadController = Get.put(LeadController());

//   LeadsDataData({required super.context});

//   @override
//   void onSelectAction(value, int index, int id) {
//     super.onSelectAction(value, index, id);
//     value ? leadController.selectedID.add(id) : leadController.selectedID.remove(id);
//     selectedRow.value > 0 ? leadController.isSelected.value = true : leadController.isSelected.value = false;
//   }

//   @override
//   List<TableBase> get data => leadController.models;

//   Future<Lead?> getById(int id) async {
//     return await Lead().getById(id);
//   }

//   @override
//   Future<void> onDeletePressed(index, context) async {
//     Lead? itemToDelete = await getById(index);
//     actionModal(
//       context,
//       const Text("Delete Lead"),
//       Text("Are you sure you want to delete ${itemToDelete!.name.toString()}"),
//       [
//         FilledButton(
//           onPressed: () async {
//             await leadController.deleteModel(itemToDelete);
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
//       const Text("Update Lead"),
//       LeadForm(lead: await getById(index)),
//       [],
//     );
//     super.onEditPressed(index, context);
//   }
// }