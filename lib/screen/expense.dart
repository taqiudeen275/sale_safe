import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/forms/expenseForm.dart';
import 'package:sale_safe/utils/components/table/expense_table.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';
import 'package:sale_safe/utils/utils.dart';

class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseController expenseController = Get.put(ExpenseController());
  DateTime? selectedDate;
  @override
  void initState() {
    expenseController.fetchByDate(DateTime.now());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("View Sales By Date: "),
                      SizedBox(width: 10),
                      DatePicker(
                        selected: selectedDate,
                        onChanged: (time) => setState(() {
                          selectedDate = time;
                          expenseController.fetchByDate(selectedDate!);
                        }),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(
                          child: Text("Today"),
                          onPressed: () {
                            setState(() {
                              selectedDate = DateTime.now();
                              expenseController.fetchByDate(selectedDate!);
                            });
                          })
                    ],
                  ),
                  FilledButton(
                      child: const Text("Add Expense"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const AddExpense(),
                        );
                      })
                ],
              ),
              Text(
                selectedDate != null
                    ? "${formatDateTime(selectedDate!, dateOnly: true) == formatDateTime(DateTime.now(), dateOnly: true) ? 'TODAY\'S' : formatDateTime(selectedDate!, dateOnly: true)} EXPENSES"
                    : "TODAY'S EXPENSES",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ExpenseTable(),
            ),
          ),
        ),
      ],
    );
  }
}
