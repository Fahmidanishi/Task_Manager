import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/have_account.dart';

import '../utills/app_padding.dart';
import '../widgets/sign_up_form.dart';


class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  static String name = '/SingUp';

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.authScreenSidePadding,
          ),
          child: const Column(
            children: [
              SingUpForm(),
              HaveAccountSection(),
            ],
          ),
        ),
      ),
    );
  }
}