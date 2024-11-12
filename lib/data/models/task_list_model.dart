import 'package:task_manager/data/models/task_model.dart';

class TaskListModel {
  String? status;
  List<TaskModel>? TaskList;

  TaskListModel({this.status, this.TaskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      TaskList = <TaskModel>[];
      json['data'].forEach((v) {
        TaskList!.add(new TaskModel.fromJson(v));
      });
    }
  }
}


