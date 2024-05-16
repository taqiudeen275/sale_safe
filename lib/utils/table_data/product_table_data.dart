import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/forms/productForm.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/base_table.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class ProductsDataData extends SqfEntityDBTableDataSource {
  ProductController productController = Get.put(ProductController());

  ProductsDataData({required super.context});

  @override
  void onSelectAction(value, int index, int id) {
    super.onSelectAction(value, index, id);
    value
        ? productController.selectedID.add(id)
        : productController.selectedID.remove(id);
    selectedRow.value > 0
        ? productController.isSelected.value = true
        : productController.isSelected.value = false;
  }

  @override
  List<TableBase> get data => productController.models;

  @override
  List<Map> get dataRow => productController.models
      .map((product) => {
            'id': product.id,
            'name': product.name,
            'description': product.description,
            'cost': product.cost,
            'price': product.price,
            "quantity": product.quantity,
          })
      .toList();

  Future<Product?> getById(int id) async {
    return await Product().getById(id);
  }

  @override
  Future<void> onDeletePressed(index, context) async {
    Product? itemToDelete = await getById(index);
    actionModal(
      context,
      const Text("Delete Product"),
      Text("Are you sure you want to delete ${itemToDelete!.name.toString()}"),
      [
        FilledButton(
          onPressed: () async {
            await productController.deleteModel(itemToDelete);
            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
      ],
    );
    super.onDeletePressed(index, context);
  }

  @override
  Future<void> onEditPressed(index, context) async {
    actionModal(
      context,
      const Text("Update Product"),
      ProductAdd(product: await getById(index)),
      [],
    );
    super.onEditPressed(index, context);
  }
}
