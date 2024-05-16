import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/forms/categoryForm.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/base_table.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class CategoriesDataData extends SqfEntityDBTableDataSource {
  CategoryController catController = Get.put(CategoryController());

  CategoriesDataData({required super.context});

  @override
  void onSelectAction(value, int index, int id) {
    super.onSelectAction(value, index, id);
    value
        ? catController.selectedID.add(id)
        : catController.selectedID.remove(id);

    selectedRow.value > 0
        ? catController.isSelected.value = true
        : catController.isSelected.value = false;
  }

  late final dbdata = catController.models
      .map((product) => {
            'id': product.id,
            'name': product.name,
            // Add more fields as needed
          })
      .toList();

  @override
  List<TableBase> get data => catController.models.toList();


  @override
  List<Map> get dataRow => dbdata;

  Future<Category?> getById(int id) async {
    return await Category().getById(id);
  }

  @override
  Future<void> onDeletePressed(index, context) async {
    Category? itemToDelete = await getById(index);
    actionModal(
        context,
        const Text("Delete Academic Year"),
        Text(
            "Are you sure you want to delete ${itemToDelete!.name.toString()}"),
        [
          FilledButton(
              onPressed: () async {
                await catController.deleteModel(itemToDelete);
                Navigator.pop(context);
              },
              child: const Text("Yes")),
          fluent_ui.Button(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
        ]);
    // TODO: implement onDeletePressed
    super.onDeletePressed(index, context);
  }

  @override
  Future<void> onEditPressed(index, context) async {
    actionModal(context, const Text("Update Academic Year"),
        CategoryAdd(category: await getById(index)), []);
    super.onEditPressed(index, context);
  }
}
