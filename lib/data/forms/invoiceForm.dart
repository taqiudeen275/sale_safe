
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class InvoiceAdd extends StatefulWidget {
// If update then pass in an Academic year instance
  final Sale sale;
  const InvoiceAdd({super.key,required this.sale});

  @override
  State<StatefulWidget> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  // Add controllers for other fields as needed
  InvoiceController invoiceController =
      Get.put(InvoiceController());

SaleController saleCOntroller =
      Get.put(SaleController());
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    // TODO: implement dispose
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
                  return 'Please enter academic year';
                }
                return null;
              },
            ),
           
            // Add other fields as needed

            // Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
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

  void _submitForm() {
    // Perform actions when the form is submitted
    // String cat_name = _nameController.text;
   
    // Clear form fields
    _nameController.clear();
    Navigator.pop(context);
    // Clear other fields as needed
  }
}
