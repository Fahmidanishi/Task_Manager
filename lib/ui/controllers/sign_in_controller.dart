import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

import '../../data/models/long_in_model.dart';
import '../screens/home_screen.dart';


class SingInController extends GetxController {

  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;



  Future<bool> singIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );
    if (networkResponse.isSuccess) {
      final LongInModel longInModel =
      LongInModel.fromJson(networkResponse.responseBody);
      await AuthController.saveAccessToken(longInModel.token!);
      await AuthController.saveUserData(longInModel.userData!);
      Get.offAllNamed(HomeScreen.name);
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}