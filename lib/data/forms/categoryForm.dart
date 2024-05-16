
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class CategoryAdd extends StatefulWidget {
// If update then pass in an Academic year instance
  final Category? category;
  const CategoryAdd({super.key, this.category});

  @override
  State<StatefulWidget> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  // Add controllers for other fields as needed
  CategoryController catController =
      Get.put(CategoryController());

  @override
  void initState() {
    _nameController.text = (widget.category == null
        ? ''
        : widget.category?.name.toString())!;

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
              placeholder: 'Enter academic year name',
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
    String cat_name = _nameController.text;
    if (widget.category != null) {
      Category? model = widget.category;
      model?.name = cat_name;
      catController.addModel(model!);
    } else {
      Category model = Category();
      model.name = cat_name;
      catController.addModel(model);
    }
    // Clear form fields
    _nameController.clear();
    Navigator.pop(context);
    // Clear other fields as needed
  }
}
