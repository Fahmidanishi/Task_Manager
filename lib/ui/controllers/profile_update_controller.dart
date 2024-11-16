import 'dart:io';
import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/user_data_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';


import 'auth_controller.dart';

class ProfileUpdateController extends GetxController {
  bool get inProgress => _inProgress;

  bool _inProgress = false;

  String? _errorMessage;

  String? _successMessage;

  File? _selectedImage;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  void setImage(File image){
    _selectedImage = image;
    update();
  }

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password,) async {
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
    if (password != '') {
      requestBody['password'] = password;
    }
    if (_selectedImage != null) {
      requestBody['photo'] = _selectedImage!.path;
    }

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.profileUpdate,
      body: requestBody,
    );
    if (networkResponse.isSuccess) {
      final UserData userData = UserData.fromJson(requestBody,
      );
      await AuthController.saveUserData(userData);
      Get.back();
      _successMessage = 'Profile updated';
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}