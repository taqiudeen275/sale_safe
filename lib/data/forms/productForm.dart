import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class ProductAdd extends StatefulWidget {
  // If update then pass in a Product instance
  final Product? product;
  const ProductAdd({super.key, this.product});

  @override
  State<StatefulWidget> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    _nameController.text = widget.product?.name ?? '';
    _descriptionController.text = widget.product?.description ?? '';
    _costController.text = widget.product?.cost?.toString() ?? '';
    _priceController.text = widget.product?.price?.toString() ?? '';
    _quantityController.text = widget.product?.quantity?.toString() ?? '';
    // for (Product product in products) {
    //   product.save();
      
    // }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Name
            TextFormBox(
              controller: _nameController,
              placeholder: 'Enter product name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            // Product Description
            TextBox(
              controller: _descriptionController,
              placeholder: 'Enter product description (optional)',
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            // Product Cost
            TextFormBox(
              controller: _costController,
              placeholder: 'Enter product cost',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product cost';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            // Product Price
            TextFormBox(
              controller: _priceController,
              placeholder: 'Enter product price',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product price';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            // Product Quantity
            TextFormBox(
              controller: _quantityController,
              placeholder: 'Enter product quantity',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            // Submit Button
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _submitForm();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    String name = _nameController.text;
    String description = _descriptionController.text;
    double cost = double.tryParse(_costController.text) ?? 0.0;
    double price = double.tryParse(_priceController.text) ?? 0.0;
    int quantity = int.tryParse(_quantityController.text) ?? 0;

    // Check if update or create based on passed product
    if (widget.product != null) {
      Product model = widget.product!;
      model.name = name;
      model.description = description;
      model.cost = cost;
      model.price = price;
      model.quantity = quantity;
      productController.updateModel(model);
    } else {
      Product model = Product(
        name: name,
        description: description,
        cost: cost,
        price: price,
        quantity: quantity,
      );
      productController.addModel(model);
    }

    // Clear form fields
    _nameController.clear();
    _descriptionController.clear();
    _costController.clear();
    _priceController.clear();
    _quantityController.clear();
    Navigator.pop(context);
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
