import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sale_safe/data/forms/productForm.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/table/product_table.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController productController = Get.put(ProductController());

  final TextEditingController _productSearchController =
      TextEditingController();

  @override
  void initState() {
    _productSearchController.text = "";

    // for (Product prod in products) {
    //   prod.save();
    // }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _productSearchController.dispose();
    productController.searchQuery.value = "";
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          if (productController.searchQuery.value.isEmpty) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.865,
                child: const SingleChildScrollView(child: ProductTableView()));
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
                            decoration: BoxDecoration(color: Colors.grey[50]),
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
                        ...productController
                            .onSearched()
                            .map((product) => TableRow(children: [
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
                                              actionModal(
                                                context,
                                                const Text("Update Product"),
                                                ProductAdd(product: (product)),
                                                [],
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
                                                          .deleteModel(product);
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
        }),
      ],
    );
  }
}

List<Product> products = [
  Product(
    name: 'PVC Pipe',
    description: 'Schedule 40 PVC pipe, 1-inch diameter, 10ft length',
    cost: 2.50,
    price: 4.99,
    quantity: 50,
  ),
  Product(
    name: 'Copper Pipe',
    description: 'Type L copper pipe, 1/2-inch diameter, 10ft length',
    cost: 8.75,
    price: 12.99,
    quantity: 30,
  ),
  Product(
    name: 'PEX Tubing',
    description:
        'Cross-linked polyethylene tubing, 1/2-inch diameter, 100ft coil',
    cost: 25.00,
    price: 39.99,
    quantity: 20,
  ),
  Product(
    name: 'Toilet',
    description: 'Two-piece elongated toilet with a 12-inch rough-in',
    cost: 75.00,
    price: 149.99,
    quantity: 15,
  ),
  Product(
    name: 'Bathroom Sink',
    description: 'Vitreous china undermount sink with overflow',
    cost: 45.00,
    price: 89.99,
    quantity: 10,
  ),
  Product(
    name: 'Faucet',
    description: 'Two-handle centerset bathroom faucet with a 4-inch center',
    cost: 25.00,
    price: 49.99,
    quantity: 20,
  ),
  Product(
    name: 'Showerhead',
    description: 'Multi-function showerhead with adjustable spray patterns',
    cost: 15.00,
    price: 29.99,
    quantity: 25,
  ),
  Product(
    name: 'Bathtub',
    description: 'Acrylic alcove bathtub with a right-hand drain',
    cost: 200.00,
    price: 399.99,
    quantity: 8,
  ),
  Product(
    name: 'Plunger',
    description: 'Heavy-duty rubber plunger for clearing clogs',
    cost: 5.00,
    price: 9.99,
    quantity: 40,
  ),
  Product(
    name: 'Plumber\'s Snake',
    description: 'Flexible steel plumber\'s snake for unclogging drains',
    cost: 20.00,
    price: 39.99,
    quantity: 15,
  ),
  Product(
    name: 'Pipe Wrench',
    description:
        'Heavy-duty 14-inch pipe wrench for tightening and loosening pipes',
    cost: 15.00,
    price: 29.99,
    quantity: 25,
  ),
  Product(
    name: 'Soldering Kit',
    description: 'Complete soldering kit for making copper pipe connections',
    cost: 35.00,
    price: 69.99,
    quantity: 10,
  ),
  Product(
    name: 'PVC Cement',
    description: 'Heavy-duty PVC cement for joining PVC pipes and fittings',
    cost: 3.50,
    price: 6.99,
    quantity: 30,
  ),
  Product(
    name: 'Tub and Tile Caulk',
    description: 'Flexible silicone caulk for sealing around tubs and tiles',
    cost: 2.00,
    price: 3.99,
    quantity: 50,
  ),
  Product(
    name: 'Toilet Auger',
    description: 'Closet auger for clearing toilet clogs',
    cost: 10.00,
    price: 19.99,
    quantity: 20,
  ),
  Product(
    name: 'Sink Strainer',
    description: 'Stainless steel sink strainer to catch debris',
    cost: 2.50,
    price: 4.99,
    quantity: 40,
  ),
  Product(
    name: 'Drain Cover',
    description:
        'Silicone drain cover for preventing hair and debris from clogging drains',
    cost: 1.50,
    price: 2.99,
    quantity: 60,
  ),
  Product(
    name: 'Toilet Flapper',
    description: 'Universal toilet flapper for repairing running toilets',
    cost: 2.00,
    price: 3.99,
    quantity: 50,
  ),
  Product(
    name: 'Garden Hose',
    description: 'Heavy-duty 50ft garden hose for outdoor water connections',
    cost: 15.00,
    price: 29.99,
    quantity: 25,
  ),
  Product(
    name: 'Hose Nozzle',
    description: 'Adjustable hose nozzle with multiple spray patterns',
    cost: 5.00,
    price: 9.99,
    quantity: 35,
  ),
  Product(
    name: 'Water Shut-off Valve',
    description: 'Quarter-turn ball valve for shutting off water supply',
    cost: 8.00,
    price: 15.99,
    quantity: 30,
  ),
  Product(
    name: 'Water Heater Blanket',
    description: 'Insulation blanket for reducing heat loss from water heaters',
    cost: 10.00,
    price: 19.99,
    quantity: 20,
  ),
  Product(
    name: 'Pipe Insulation',
    description: 'Foam pipe insulation to prevent condensation and energy loss',
    cost: 0.75,
    price: 1.49,
    quantity: 100,
  ),
  Product(
    name: 'Pipe Hangers',
    description: 'Adjustable pipe hangers for supporting pipes',
    cost: 1.50,
    price: 2.99,
    quantity: 50,
  ),
  Product(
    name: 'Teflon Tape',
    description: 'Teflon tape for sealing threaded pipe connections',
    cost: 0.50,
    price: 0.99,
    quantity: 75,
  ),
  Product(
    name: 'Plumber\'s Torch',
    description: 'Turbo torch for soldering copper pipes',
    cost: 25.00,
    price: 49.99,
    quantity: 15,
  ),
  Product(
    name: 'Plumber\'s Putty',
    description: 'Non-hardening putty for sealing drains and fixtures',
    cost: 2.50,
    price: 4.99,
    quantity: 40,
  ),
  Product(
    name: 'Plumber\'s Hacksaw',
    description: 'Heavy-duty hacksaw for cutting pipes and other materials',
    cost: 10.00,
    price: 19.99,
    quantity: 25,
  ),
  Product(
    name: 'Pipe Deburring Tool',
    description: 'Tool for removing burrs from the ends of cut pipes',
    cost: 5.00,
    price: 9.99,
    quantity: 30,
  ),
];
