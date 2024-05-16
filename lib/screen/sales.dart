import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/orderPick.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class SalesScreen extends StatefulWidget {
  SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final ProductController productController = Get.put(ProductController());
  final SaleController salesController = Get.put(SaleController());
  final InvoiceController invoiceController = Get.put(InvoiceController());

  final OrderController orderController = Get.put(OrderController());
  RxBool isCredit = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Text(productController.selectedItems.length.toString()),
            FilledButton(
                onPressed: () {
                  bigActionModal(context, const Text("Add Sale"), OrderPick(), [
                    FilledButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Obx(() => Row(
                      children: [
                        const Text("Credit Sale"),
                        const SizedBox(width: 10,),

                        ToggleSwitch(
                          checked: isCredit.value,
                          onChanged:  productController.selectedItems.isEmpty
                                  ? null: (bool value) {
                            isCredit.value = value;
                            
                          },
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: FilledButton(
                              onPressed: productController.selectedItems.isEmpty
                                  ? null
                                  : () async {
                                      await orderController.onItemSelectedSave();
                                      Sale saleAdded = Sale(
                                        isCredit: isCredit.value,
                                          date: DateTime.now(),
                                          amount: orderController.selectedItems
                                              .fold(
                                                  0.0,
                                                  (sum, product) =>
                                                      sum! +
                                                      (product.amount! *
                                                          product.quantity!)));
                                      await salesController.addModel(saleAdded);
                                    },
                              child: const Text("Record Sale")),
                        ),
                      ],
                    )),
                  ]);
                },
                child: const Text("Select Product"))
          ],
        ));
  }
}
