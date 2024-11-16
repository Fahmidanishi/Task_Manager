import 'package:flutter/material.dart';
import 'package:task_manager/ui/utills/app_colors.dart';


void snackBarMessage(BuildContext context,String message,[bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError? Colors.red : AppColors.backgroundColor,
    ),
  );
}