import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:sale_safe/utils/components/password_update.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  UtilityController utilityController = UtilityController();

  RxBool isDark = false.obs;
  @override
  Widget build(BuildContext context) {
    return const Column(
          children: [
    PasswordUpdate(),
          ],
        
        );
  }
}
