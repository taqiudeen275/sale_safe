import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/forms/expenseForm.dart';
import 'package:sale_safe/data/forms/productForm.dart';
import 'package:sale_safe/data/forms/suppliersForm.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/orderPick.dart';
import 'package:sale_safe/utils/components/passwordUpdare.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductController productController = Get.put(ProductController());
  final SaleController salesController = Get.put(SaleController());
  final ExpenseController expenseController = Get.put(ExpenseController());
  final SupplierController supplierController = Get.put(SupplierController());
  final InvoiceController invoiceController = Get.put(InvoiceController());
  UtilityController utilController = Get.put(UtilityController());

  final OrderController orderController = Get.put(OrderController());
  RxBool isCredit = false.obs;
  DateTime? selectedDate;
  @override
  void initState() {
    salesController.fetchByDate(DateTime.now());
    expenseController.fetchByDate(DateTime.now());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value) {
        return const Expanded(child: Center(child: const ProgressRing()));
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "Sale Safe",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[150]),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CommandBar(
                      overflowBehavior: CommandBarOverflowBehavior.noWrap,
                      primaryItems: [
                        CommandBarBuilderItem(
                          builder: (context, mode, w) => Tooltip(
                            message: "Record a new sale",
                            child: w,
                          ),
                          wrappedItem: CommandBarButton(
                            icon: const Icon(FluentIcons.add),
                            label: const Text('Record Sale'),
                            onPressed: () {
                              bigActionModal(context, const Text("Add Sale"),
                                  OrderPick(), [
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
                                          onChanged: productController
                                                  .selectedItems.isEmpty
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
                                              onPressed: productController
                                                      .selectedItems.isEmpty
                                                  ? null
                                                  : () async {
                                                      await saleItemAdd();
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pop(context);
                                                    },
                                              child: const Text("Record Sale")),
                                        ),
                                      ],
                                    )),
                              ]);
                            },
                          ),
                        ),
                        CommandBarBuilderItem(
                          builder: (context, mode, w) => Tooltip(
                            message: "Add an expense!",
                            child: w,
                          ),
                          wrappedItem: CommandBarButton(
                            icon: const Icon(FluentIcons.add),
                            label: const Text('Add Expense'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AddExpense(),
                              );
                            },
                          ),
                        ),
                        CommandBarBuilderItem(
                          builder: (context, mode, w) => Tooltip(
                            message: "Add a supplier!",
                            child: w,
                          ),
                          wrappedItem: CommandBarButton(
                            icon: const Icon(FluentIcons.add),
                            label: const Text('Add Supplier'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AddSupplier(),
                              );
                            },
                          ),
                        ),
                      ]),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(children: [
                            const Text(
                              "Total Product",
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              productController.models.length.toString(),
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.orange),
                            )
                          ]),
                        ),
                      ),
                      Card(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(20),
                        child: Column(children: [
                          const Text(
                            "Today Total Sale",
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            salesController.salesByDate.length.toString(),
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                color: Colors.green),
                          )
                        ]),
                      ),
                      Expanded(
                        child: Card(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(children: [
                            const Text(
                              "Today's Total Expense",
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              expenseController.expenseByDate.length.toString(),
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red),
                            )
                          ]),
                        ),
                      ),
                      Card(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(20),
                        child: Column(children: [
                          const Text(
                            "Total Suppliers",
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            supplierController.models.length.toString(),
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue),
                          )
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(children: [
                            const Text(
                              "Today's Sale",
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              "GH¢  ${salesController.salesByDate.fold(0.0, (previousValue, element) => previousValue + element.amount!)}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey[100]),
                            )
                          ]),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(children: [
                            const Text(
                              "Today's Expense",
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              "GH¢  ${expenseController.expenseByDate.fold(0.0, (previousValue, element) => previousValue + element.amount!)}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey[100]),
                            )
                          ]),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(children: [
                            const Text(
                              "Today's Revenue",
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              "GH¢  ${(salesController.salesByDate.fold(0.0, (previousValue, element) => previousValue + element.amount!) - expenseController.expenseByDate.fold(0.0, (previousValue, element) => previousValue + element.amount!)).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.successPrimaryColor),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Card(
                      child: Column(
                    children: [
                      Text(
                          "${productController.getLowProductQuantity().length} Products Running Low in Stock",
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      ...productController
                          .getLowProductQuantity()
                          .map((e) => ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                title: Text(e.name!),
                                subtitle: Text(e.description!),
                                onPressed: () {},
                                leading: Text(
                                  "${e.quantity!} items left",
                                  style: TextStyle(color: Colors.red),
                                ),
                                trailing: IconButton(
                                    icon: utilController
                                          .isAuthenticated.value? const Icon(FluentIcons.edit): const Icon(FluentIcons.lock),
                                    onPressed: () {
                                      if (utilController
                                          .isAuthenticated.value) {
                                        actionModal(
                                          context,
                                          const Text("Update Product"),
                                          ProductAdd(product: (e)),
                                          [],
                                        );
                                      } else {
                                        actionModal(
                                            context,
                                            const Text("Login"),
                                            const PassWordChecker(), [
                                          Button(
                                              child: const Text("Close"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ]);
                                      }
                                    }),
                              ))
                    ],
                  ))
                ]),
          ),
        );
      }
    });
  }

  Future<void> saleItemAdd() async {
    int saleId = await salesController.addGetModel(Sale(
        isCredit: isCredit.value,
        date: DateTime.now(),
        amount: orderController.selectedItems
            .fold(0.0, (sum, product) => sum! + product.amount!)));

    await orderController.onItemSelectedSave(saleId);

    productController.onProuctSale(
        productController.selectedItems,
        orderController.selectedItems
            .map((element) => element.quantity ?? 0)
            .toList());
    await productController.fetchModels();
    await salesController.fetchByDate(DateTime.now());
  }
}
