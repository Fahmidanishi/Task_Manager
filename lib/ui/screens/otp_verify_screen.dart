import 'package:flutter/material.dart';
import 'package:task_manager/ui/utills/app_padding.dart';
import 'package:task_manager/ui/widgets/otp_verify_form.dart';

import '../widgets/have_account.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});

  static String name = '/otp';

  final String email;

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
                OtpVerifyForm(email: email),
                const HaveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}