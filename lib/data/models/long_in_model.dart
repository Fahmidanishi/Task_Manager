
import 'package:task_manager/data/models/user_data_model.dart';

class LongInModel {
  String? status;
  UserData? userData;
  String? token;

  LongInModel({this.status, this.userData, this.token});

  LongInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (userData != null) {
      data['data'] = userData!.toJson();
    }
    data['token'] = token;
    return data;
  }
}