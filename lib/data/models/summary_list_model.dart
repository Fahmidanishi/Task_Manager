

import 'task_count_model.dart';

class SummaryListModel {
  String? status;
  List<TaskCountModel>? data;

  SummaryListModel({this.status, this.data});

  SummaryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskCountModel>[];
      json['data'].forEach((v) {
        data!.add(TaskCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}