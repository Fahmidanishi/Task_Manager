
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskDeleteController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> taskDelete(String taskId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse networkResponse = await NetworkCaller.getRequest(
      url: Urls.deleteTask(taskId),
    );
    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    return isSuccess;
  }
}
