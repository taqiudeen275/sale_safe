import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material_ui;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sale_safe/data/forms/product_form.dart'; // Replace with your product form path
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/table/table.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/table_data/product_table_data.dart';

class ProductTableView extends StatefulWidget {
  const ProductTableView({super.key});

  @override
  State<ProductTableView> createState() => _ProductTableViewState();
}

class _ProductTableViewState extends State<ProductTableView> {
  ProductController productController = Get.put(ProductController());

  RxInt sortColumnIndex = 0.obs;
  RxBool sortAscending = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.models.isNotEmpty) {
        return SqfEntityDBTable(
          addTitle: const Text('Add Product'),
          addContent:
              const ProductAdd(), // Replace with your product form widget
          header: "Products",
          headerSize: 24,
          rowsPerPage: 10,
          columns: const [
            material_ui.DataColumn(
              label: Text("ID"),
              numeric: true,
              tooltip: "ID",
            ),
            material_ui.DataColumn(
              label: Text("Name"),
              tooltip: "Name",
              numeric: true,
            ),
            material_ui.DataColumn(
              label: Text("Description"),
              tooltip: "Description",
            ),
            material_ui.DataColumn(
              label: Text("Cost GH¢"),
              numeric: true,
              tooltip: "Cost",
            ),
            material_ui.DataColumn(
              label: Text("Price GH¢"),
              numeric: true,
              tooltip: "Price",
            ),
            material_ui.DataColumn(
              label: Text("Quantity"),
              numeric: true,
              tooltip: "Quantity",
            ),
            material_ui.DataColumn(
              label: Text("Action"),
              numeric: true,
              tooltip: "Action",
            ),
          ],
          source: ProductsDataData(context: context),
          extra_action: [
            Obx(() => productController.isSelected.value
                ? Button(
                    child: const Row(
                      children: [
                        Icon(Iconsax.trash),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Selected'),
                      ],
                    ),
                    onPressed: () async {
                      actionModal(
                          context,
                          const Text("Delete Selected"),
                          Text(
                              "Are you sure you want to delete the ${productController.selectedID.length} selected Products?"),
                          [
                            FilledButton(
                              child: const Text('Yes'),
                              onPressed: () async {
                                await productController.deleteBulkByID(
                                    productController.selectedID);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              },
                            ),
                            Button(
                              child: const Text('No'),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ]);
                    })
                : const SizedBox()),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('No Product available'),
            const SizedBox(
              height: 10,
            ),
            material_ui.FilledButton.tonal(
              child: const Text("Add Product"),
              onPressed: () {
                actionModal(
                  context,
                  const Text('Add Product'),
                  const ProductAdd(),
                  [
                    FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"))
                  ],
                ); // Replace with your product form widget
              },
            ),
          ],
        );
      }
    });
  }
}
