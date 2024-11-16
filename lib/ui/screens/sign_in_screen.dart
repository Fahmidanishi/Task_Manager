import 'package:flutter/material.dart';
import 'package:task_manager/ui/utills/app_padding.dart';

import '../widgets/sign_in_form.dart';
import 'forgot_account.dart';


class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  static String name = '/SingIn';

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.authScreenSidePadding,
          ),
          child: SingleChildScrollView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.2),
                const SingInFormSection(),
                const ForgotAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}