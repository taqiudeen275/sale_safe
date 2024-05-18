import 'package:fluent_ui/fluent_ui.dart';
import 'package:sale_safe/utils/controller/base_controller.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({super.key});

  @override
  _PasswordUpdateState createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  UtilityController utilityController = UtilityController();

  final _formKey = GlobalKey<FormState>();

  void _updatePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform password update logic here
      final currentPassword = _currentPasswordController.text;
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;

      // Example: You might want to call an API to update the password
      if (currentPassword == utilityController.getAdminPass) {
        if (newPassword == confirmPassword) {
          utilityController.setAdminPass(newPassword);
          showDialog(
            context: context,
            builder: (context) {
              return ContentDialog(
                title: const Text('Success'),
                content: const Text('Password updated successfully.'),
                actions: [
                  Button(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }else{

        }
      }

      // Clear the text fields after successful update
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormBox(
              controller: _currentPasswordController,
              obscureText: true,
              placeholder: 'Enter your current password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your current password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormBox(
              controller: _newPasswordController,
              obscureText: true,
              placeholder: 'Enter your new password',
            ),
            const SizedBox(height: 16.0),
            TextFormBox(
              placeholder: 'Confirm New Password',
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            Button(
              onPressed: _updatePassword,
              child: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
