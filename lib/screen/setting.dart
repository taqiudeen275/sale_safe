import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/prd.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/password_update.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UtilityController utilityController = UtilityController();

  final ProductController productController = Get.put(ProductController());

  RxBool isDark = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Button(
              child: const Text("Load Default Product"),
              onPressed: () async {
                if (utilityController.addDefaultProduct == "yes") {
                  for (Product prod in products) {
                    await prod.save();
                  }
                  utilityController.setaddDefaultProduct("no");
                  productController.fetchModels();
                  // ignore: use_build_context_synchronously
                setState(() {
                  actionModal(context, const Text("Products added succesffully"),
                      const Text("Default products added succesffully"), [
                    Button(
                        child: const Text("Close"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]);
                });
                }
              }),
        ),
        const PasswordUpdate(),
      ],
    );
  }
}
