import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/controllers/profile_update_controller.dart';

import 'snack_bar_message.dart';
import 'tm_process_indicator.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  final ProfileUpdateController _profileUpdateController =
  Get.find<ProfileUpdateController>();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.026),
          TextFormField(
            enabled: false,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: size.height * 0.010),
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(
              labelText: 'First Name',
            ),

          ),
          SizedBox(height: size.height * 0.010),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(
              labelText: 'Last Name',
            ),
          ),
          SizedBox(height: size.height * 0.010),
          TextFormField(
            controller: _mobileTEController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Mobile',
            ),
          ),
          SizedBox(height: size.height * 0.010),
          TextFormField(
            controller: _passwordTEController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: size.height * 0.036),
          GetBuilder<ProfileUpdateController>(builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
              replacement: const TMProgressIndicator(),
              child: ElevatedButton(
                onPressed: _onTapNextScreen,
                child: const Text('Save'),
              ),
            );
          }),
          SizedBox(height: size.height * 0.046),
        ],
      ),
    );
  }

  void _onTapNextScreen() {
    if(!_globalKey.currentState!.validate()){
      return;
    }
    _updateProfile();
  }

  Future<void> _updateProfile() async {
    bool result = await _profileUpdateController.updateProfile(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTEController.text,
    );
    if (result) {
      snackMassage(false, _profileUpdateController.successMessage!);
    } else {
      snackMassage(false, _profileUpdateController.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }
}