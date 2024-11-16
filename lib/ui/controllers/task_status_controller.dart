import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/summary_list_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';


class TaskStatusController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<TaskCountModel> _taskCountList = [];

  List<TaskCountModel> get taskCountList => _taskCountList;

  Future<bool> getStatusCount() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCaller.getRequest(
      url: Urls.taskStatusCount,
    );

    if (networkResponse.isSuccess) {
      SummaryListModel summaryListModel = SummaryListModel.fromJson(
        networkResponse.responseBody,
      );
      _taskCountList = summaryListModel.data ?? [];

      isSuccess = true;
      update();
    } else {
      _errorMessage = networkResponse.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}