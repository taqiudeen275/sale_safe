import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/data/prd.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/components/password_update.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  UtilityController utilityController = UtilityController();

  RxBool isDark = false.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
            child: const Text("Load Default Product"),
            onPressed: () async {
              if (utilityController.addDefaultProduct == "yes") {
                for (Product prod in products) {
                  await prod.save();
                }
                utilityController.setaddDefaultProduct("no");
              }
            }),
        const PasswordUpdate(),
      ],
    );
  }
}
