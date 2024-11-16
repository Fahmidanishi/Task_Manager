import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class CancelTaskController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<TaskModel> _taskList = [];

  List<TaskModel> get taskList => _taskList;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> getCancelTask() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse networkResponse = await NetworkCaller.getRequest(
      url: Urls.listTaskByStatus('Canceled'),
    );

    if (networkResponse.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        networkResponse.responseBody,
      );

      _taskList = taskListModel.data ?? [];

      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}