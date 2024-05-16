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
            Text(orderController.models.length.toString()),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,

              child: RecordSale(
                  isCredit: isCredit,
                  productController: productController,
                  salesController: salesController,
                  orderController: orderController),
            ),
            ...salesController.models.map((element) =>  Expander(
                  header: Text('SalesID ${element.id.toString()}'),
                  content: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      child: Text('Amount ${element.amount.toString()}'),
                    ),
                  ),
                ))
          ],
        ));
  }
}

class RecordSale extends StatelessWidget {
  const RecordSale({
    super.key,
    required this.isCredit,
    required this.productController,
    required this.salesController,
    required this.orderController,
  });

  final RxBool isCredit;
  final ProductController productController;
  final SaleController salesController;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
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
                    const SizedBox(
                      width: 10,
                    ),
                    ToggleSwitch(
                      checked: isCredit.value,
                      onChanged: productController.selectedItems.isEmpty
                          ? null
                          : (bool value) {
                              isCredit.value = value;
                            },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FilledButton(
                          onPressed: productController.selectedItems.isEmpty
                              ? null
                              : () async {
                                  
                                      await salesController.addModel(Sale(
                                          isCredit: isCredit.value,
                                          date: DateTime.now(),
                                          amount: orderController.selectedItems
                                              .fold(
                                                  0.0,
                                                  (sum, product) =>
                                                      sum! +
                                                      (product.amount! *
                                                          product.quantity!))));
                                  await orderController
                                      .onItemSelectedSave(salesController.models.last);
                                  Navigator.pop(context);
                                },
                          child: const Text("Record Sale")),
                    ),
                  ],
                )),
          ]);
        },
        child: const Text("Select Product"));
  }
}
