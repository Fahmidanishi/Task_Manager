import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';


class TaskUpdateController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> updateTask(String userId, String status) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatus(userId, status),
    );

    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}