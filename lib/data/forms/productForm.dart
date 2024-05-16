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
