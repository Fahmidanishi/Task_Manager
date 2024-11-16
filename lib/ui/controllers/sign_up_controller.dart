import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';


class SingUpController extends GetxController {
  bool get inProgress => _inProgress;

  bool _inProgress = false;

  String? _errorMessage;

  String? _successMessage;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  Future<bool> singUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password
    };

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );
    if (networkResponse.isSuccess) {
      Get.back();
      _successMessage = 'Account created';
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}