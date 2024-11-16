import 'package:flutter/material.dart';
import 'package:task_manager/ui/utills/app_padding.dart';
import 'package:task_manager/ui/widgets/have_account.dart';

import '../widgets/verify_email_form.dart';


class VerityEmailScreen extends StatefulWidget {
  const VerityEmailScreen({super.key});

  static String name = '/email';

  @override
  State<VerityEmailScreen> createState() =>
      _VerityEmailScreenState();
}

class _VerityEmailScreenState extends State<VerityEmailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.authScreenSidePadding,
          ),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                VerifyEmailForm(),
                HaveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}