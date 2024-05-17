import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/utils.dart';

class InvoiceAdd extends StatefulWidget {
// If update then pass in an Academic year instance
  final Sale sale;
  const InvoiceAdd({super.key, required this.sale});

  @override
  State<StatefulWidget> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  // Add controllers for other fields as needed
  InvoiceController invoiceController = Get.put(InvoiceController());

  SaleController saleCOntroller = Get.put(SaleController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
            // Academic Year Name
            TextFormBox(
              controller: _nameController,
              placeholder: 'To',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the customer name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Add other fields as needed

            // Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                   await _submitForm();
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    // Perform actions when the form is submitted
    String to = _nameController.text;
    await invoiceController.addModel(Invoice(customer_name: to,salesId: widget.sale.id, date: DateTime.now(),amount: widget.sale.amount,invoice_number: generateInvoiceNumber()));
    await saleCOntroller.fetchByDate(DateTime.now());
    // Clear form fields
    _nameController.clear();
    Navigator.pop(context);
    // Clear other fields as needed
  }
}
