import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sale_safe/data/forms/product_form.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/password_update.dart';
import 'package:sale_safe/utils/components/table/product_record_table.dart';
import 'package:sale_safe/utils/components/table/product_table.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController productController = Get.put(ProductController());
  UtilityController utilController = Get.put(UtilityController());

  final TextEditingController _productSearchController =
      TextEditingController();

  @override
  void initState() {
    _productSearchController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _productSearchController.dispose();
    productController.searchQuery.value = "";
    super.dispose();
  }

  Future<Product?> getById(int id) async {
    return await Product().getById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (utilController.isAuthenticated.value) {
        return Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.135,
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextBox(
                  controller: _productSearchController,
                  prefix: IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: () {
                      _productSearchController.text = "";
                      productController.searchQuery.value = "";
                    },
                  ),
                  placeholder: "Product Search",
                  onChanged: (value) {
                    productController.searchQuery.value = value;
                  },
                )),
            Obx(() {
              if (productController.isLoading.value) {
                return const ProgressRing();
              } else {
                if (productController.searchQuery.value.isEmpty) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.865,
                      child: const SingleChildScrollView(
                          child: ProductTableView()));
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.865,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Product Search Results",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Table(
                            columnWidths: const {
                              2: FixedColumnWidth(90.0),
                              3: FixedColumnWidth(90.0),
                              4: FixedColumnWidth(120.0),
                            },
                            children: [
                              TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[50]),
                                  children: const [
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Cost GH¢',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Price GH¢',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Action',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              ...productController.onSearched().map((product) =>
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${product.name}'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${product.description}'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${product.cost}'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${product.price}'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${product.quantity}'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                              
                                                List<ProductRecord>
                                                    productRecord =
                                                    await ProductRecord()
                                                        .select()
                                                        .productId
                                                        .equals(product.id)
                                                        .toList();
                                                // ignore: use_build_context_synchronously
                                                bigActionModal(
                                                  context,
                                                  const Text("Product Details"),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          if (productRecord
                                                              .isNotEmpty)
                                                            ProductRecordTable(
                                                                records:
                                                                    productRecord),
                                                          if (productRecord
                                                              .isEmpty)
                                                            const Text(
                                                                "No Product records")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  [
                                                    FilledButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text("Close"))
                                                  ],
                                                );
                                              },
                                              icon:
                                                  const Icon(FluentIcons.view)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                actionModal(
                                                  context,
                                                  const Text("Update Product"),
                                                  ProductAdd(
                                                      product: (product)),
                                                  [
                                                    Button(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("No"),
                                                    ),
                                                  ],
                                                );
                                              },
                                              icon: const Icon(Iconsax.edit)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                actionModal(
                                                  context,
                                                  const Text("Delete Product"),
                                                  Text(
                                                      "Are you sure you want to delete ${product.name.toString()}"),
                                                  [
                                                    FilledButton(
                                                      onPressed: () async {
                                                        await productController
                                                            .deleteModel(
                                                                product);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Yes"),
                                                    ),
                                                    Button(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("No"),
                                                    ),
                                                  ],
                                                );
                                              },
                                              icon: const Icon(Iconsax.trash)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
            }),
          ],
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You are not authenticated. Please log in.",
              style: TextStyle(fontSize: 24),
            ),
            FilledButton(
                child: const Text("Login"),
                onPressed: () {
                  actionModal(
                      context, const Text("Login"), const PassWordChecker(), [
                    Button(
                        child: const Text("Close"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]);
                })
          ],
        );
      }
    });
  }
}
