import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class AddExpense extends StatefulWidget {

  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ExpenseController _expenseController = Get.put(ExpenseController());

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text( 'Record Expense'),
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
              placeholder: 'Amount',
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: _validateAmount,
            ),
            const SizedBox(height: 8.0),
            TextFormBox(
              placeholder: 'Description',
              controller: _descriptionController,
              maxLines: 3,
            ),
          
          
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
          child: const Text('Record Expense'),
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

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final amount = double.parse(_amountController.text);
      final description = _descriptionController.text;
      final date =  DateTime.now();

    
        final expense = Expense(
          name: name,
          amount: amount,
          description: description,
          date: date,
        );
        _expenseController.addModel(expense);
     
     await  _expenseController.fetchByDate(DateTime.now());
      // Clear form fields
      _clearFields();
      Navigator.pop(context);
    }
  }

  void _clearFields() {
    _nameController.clear();
    _amountController.clear();
    _descriptionController.clear();
  }
}

