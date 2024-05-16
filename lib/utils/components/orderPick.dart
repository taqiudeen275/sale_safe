import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as flutter_material;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class OrderPick extends StatefulWidget {
  OrderPick({super.key});

  @override
  State<OrderPick> createState() => _OrderPickState();
}

class _OrderPickState extends State<OrderPick> {
  final ProductController productController = Get.put(ProductController());

  final OrderController orderController = Get.put(OrderController());

  final TextEditingController _productSearchController =
      TextEditingController();

  @override
  void dispose() {
    orderController.selectedItems = <Order>[].obs;
    productController.selectedItems = <Product>[].obs;
    _productSearchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
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
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select Products ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              if (productController.searchQuery.value.isEmpty)
                                ...productController.models.map((product) =>
                                    GestureDetector(
                                      onTap: () {
                                        if (productController.selectedItems
                                            .contains(product)) {
                                          productController.selectedItems
                                              .remove(product);

                                          orderController.selectedItems
                                              .removeWhere((order) =>
                                                  order.productId ==
                                                  product.id);
                                        } else {
                                          orderController.selectedItems.add(
                                              Order(
                                                  productId: product.id,
                                                  amount: product.price,
                                                  quantity: 1));
                                          productController.selectedItems
                                              .add(product);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: productController.selectedItems
                                                  .contains(product)
                                              ? Colors.grey[50]
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${product.name}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 40,
                                            ),
                                            Text(
                                              "${product.description}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w100),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "GH¢ ${product.price}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w100),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              if (productController
                                  .searchQuery.value.isNotEmpty)
                                ...productController
                                    .onSearched()
                                    .map((product) => GestureDetector(
                                          onTap: () {
                                            if (productController.selectedItems
                                                .contains(product)) {
                                              productController.selectedItems
                                                  .remove(product);

                                              orderController.selectedItems
                                                  .removeWhere((order) =>
                                                      order.productId ==
                                                      product.id);
                                            } else {
                                              orderController.selectedItems.add(
                                                  Order(
                                                      productId: product.id,
                                                      amount: product.price,
                                                      quantity: 1));
                                              productController.selectedItems
                                                  .add(product);
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(7),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: productController
                                                      .selectedItems
                                                      .contains(product)
                                                  ? Colors.grey[50]
                                                  : Colors.transparent,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${product.name}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "${product.description}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "GH¢ ${product.price}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      "${productController.selectedItems.length.toString()} Selected Products ",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 24,
                                      )),
                                  Text(
                                    "TOTAL: GH¢ ${orderController.selectedItems.fold(0.0, (sum, order) => sum + (order.amount! + sum)).toString()}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  itemCount:
                                      orderController.selectedItems.length,
                                  itemBuilder: (context, index) {
                                    Order order =
                                        orderController.selectedItems[index];

                                    Product product =
                                        productController.selectedItems[index];

                                    return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 4),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[50]),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${product.name}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${product.description}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w100),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color:
                                                    flutter_material.Theme.of(
                                                            context)
                                                        .cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      icon: const Icon(FluentIcons
                                                          .calculator_subtract),
                                                      onPressed: () {
                                                        setState(() {
                                                          orderController
                                                              .decrementQuantity(
                                                                  index);
                                                          order.amount = (product
                                                                  .price! *
                                                              order.quantity!);
                                                        });
                                                      }),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Text(
                                                      "${order.quantity}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                          FluentIcons.add),
                                                      onPressed: () {
                                                        setState(() {
                                                          orderController
                                                              .incrementQuantity(
                                                                  index);
                                                                 order.quantity! > 0?
                                                          order.amount = (product
                                                                  .price! *
                                                              order.quantity!): order.amount;
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "GH¢ ${order.amount}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
