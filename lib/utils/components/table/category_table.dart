// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart' as material_ui;
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:sale_safe/data/forms/categoryForm.dart';
// import 'package:sale_safe/utils/components/modal.dart';
// import 'package:sale_safe/utils/components/table/table.dart';
// import 'package:sale_safe/utils/controller/base_controller.dart';
// import 'package:sale_safe/utils/table_data/categories_data.dart';

// class CategoryTableView extends StatefulWidget {
//   const CategoryTableView({super.key});

//   @override
//   State<CategoryTableView> createState() => _CategoryTableViewState();
// }

// class _CategoryTableViewState extends State<CategoryTableView> {
//   CategoryController categoryController = Get.put(CategoryController());

//   RxInt sortColumnIndex = 0.obs;
//   RxBool sortAscending = true.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (categoryController.models.isNotEmpty) {
//         return Column(
//           children: [
//             SqfEntityDBTable(
//               addTitle: const Text('Add Categories'),
//               addContent: const CategoryAdd(),
//               header: "Categories",
//               headerSize: 24,
//               rowsPerPage: 5,
//               columns: const [
//                 material_ui.DataColumn(
//                     label: Text("ID"), numeric: true, tooltip: "ID"),
//                 material_ui.DataColumn(
//                   label: Text("Name"),
//                   tooltip: "Name",
//                 ),
//                 material_ui.DataColumn(
//                   numeric: true,

//                     label: Text("Action"), tooltip: "Action"),
//               ],
//               source: CategoriesDataData(context: context),
//               extra_action: [
//                 Obx(() => categoryController.isSelected.value
//                     ? Button(
//                         child: const Row(
//                           children: [
//                             Icon(Iconsax.trash),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Selected')
//                           ],
//                         ),
//                         onPressed: () async {
//                           actionModal(
//                               context,
//                               const Text("Delete Selected"),
//                               Text(
//                                   "Are you sure you want to deleted the ${categoryController.selectedID.length} selected Categories?"),
//                               [
//                                 FilledButton(
//                                     child: const Text('Yes'),
//                                     onPressed: () async {
//                                       await categoryController.deleteBulkByID(
//                                           categoryController.selectedID);
//                                       // ignore: use_build_context_synchronously
//                                       Navigator.pop(context);
//                                     }),
//                                 Button(
//                                     child: const Text('No'),
//                                     onPressed: () async {
//                                       Navigator.pop(context);
//                                     }),
//                               ]);
//                         })
//                     : const SizedBox()),
//               ],
//             ),
//           ],
//         );
//       } else {
//         return FilledButton(
//             child: const Text("Add Academic Year"),
//             onPressed: () {
//               actionModal(context, const Text('Add Categories'),
//                   const CategoryAdd(), []);
//             });
//       }
//     });
//   }
// }
