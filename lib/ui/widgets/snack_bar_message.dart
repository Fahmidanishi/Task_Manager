import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackMassage(bool isError, String message) {
  Get.snackbar(
    isError == true ? 'error' : 'success',
    message,
    leftBarIndicatorColor: isError == true ? Colors.red : Colors.green,
  );
}