import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/password_controller.dart';
import 'snack_bar_message.dart';
import 'tm_process_indicator.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _newPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final PasswordController _passwordController = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.sizeOf(context);
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.2),
          Text(
            'Update password',
            style: textTheme.displayMedium,
          ),
          SizedBox(height: size.height * 0.016),
          TextFormField(
            controller: _passwordTEController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'New Password',
            ),
            validator: (value) {
              if (value!.length < 6) {
                return 'Enter value a minimum 6 character';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.010),
          TextFormField(
            controller: _newPasswordTEController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),
            validator: (value) {
              if (value!.length < 6) {
                return 'Enter value a minimum 6 character';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.026),
          GetBuilder<PasswordController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: const TMProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapNextScreen,
                    child: const Text('Update'),
                  ),
                );
              }
          ),
          SizedBox(height: size.height * 0.046),
        ],
      ),
    );
  }

  void _onTapNextScreen() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _updatePassword();
  }

  Future<void> _updatePassword() async {
    final bool result = await _passwordController.password(
      widget.email,
      widget.otp,
      _newPasswordTEController.text,
    );
    if(result){
      snackMassage(false, _passwordController.successMessage!);
    }else{
      snackMassage(true, _passwordController.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordTEController.dispose();
    _newPasswordTEController.dispose();
  }
}