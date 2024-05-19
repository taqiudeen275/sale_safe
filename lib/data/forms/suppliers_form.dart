import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({super.key});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final SupplierController _supplierController = Get.put(SupplierController());

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Add Supplier'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormBox(
              placeholder: 'Name',
              controller: _nameController,
              validator: _validateName,
            ),
            const SizedBox(height: 8.0),
            TextFormBox(
              placeholder: 'Email',
              controller: _emailController,
              validator: _validateEmail,
            ),
            const SizedBox(height: 8.0),
            TextFormBox(
              placeholder: 'Phone',
              controller: _phoneController,
              validator: _validatePhone,
            ),
            const SizedBox(height: 8.0),
            TextBox(
              placeholder: 'Description',
              controller: _descriptionController,
              maxLines: 3,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FilledButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    // Add email validation if needed
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    // Add phone number validation if needed
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final description = _descriptionController.text;
      final date = DateTime.now();

      // Create a new supplier
      final supplier = Supplier(
        name: name,
        email: email,
        phone: phone,
        description: description,
        date: date,
      );
      _supplierController.addModel(supplier);

     await _supplierController.fetchModels();
      // Clear form fields
      _clearFields();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _descriptionController.clear();
  }
}
