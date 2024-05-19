import 'package:fluent_ui/fluent_ui.dart';
import 'package:sale_safe/data/forms/suppliers_form.dart';
import 'package:sale_safe/utils/components/table/supplier_table.dart';

class SuppplierScreen extends StatefulWidget {
  const SuppplierScreen({super.key});

  @override
  State<SuppplierScreen> createState() => _SuppplierScreenState();
}

class _SuppplierScreenState extends State<SuppplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              FilledButton(
                      child: const Text("Add Supplier"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const AddSupplier(),
                        );
                      })
                ],
              ),
              const Text(
                 "SUPPLIERS",
                style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child:  const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SuppliersTable(),
            ),
          ),
        ),
      ],
    );
  }
}
