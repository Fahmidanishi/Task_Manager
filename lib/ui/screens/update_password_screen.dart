import 'package:flutter/material.dart';
import 'package:task_manager/ui/utills/app_padding.dart';
import 'package:task_manager/ui/widgets/password_form.dart';

import '../widgets/have_account.dart';
import '../widgets/neumorphism_box.dart';


class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  static String name = '/password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.authScreenSidePadding,
          ),
          child:  SingleChildScrollView(
            child: Column(
              children: [
                PasswordForm(email: email, otp: otp,),
                const HaveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}