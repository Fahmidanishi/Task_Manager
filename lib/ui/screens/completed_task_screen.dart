import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import '../../data/utils/urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskListInProgress,
      replacement: const Center(child: CircularProgressIndicator()),
      child: RefreshIndicator(
        onRefresh: _getCompletedTaskList,
        child: _completedTaskList.isEmpty
            ? Center(child: Text('No completed tasks available'))
            : ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              onRefreshList: _getCompletedTaskList,
              taskModel: _completedTaskList[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    setState(() {
      _completedTaskList.clear();
      _getCompletedTaskListInProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.completedTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      setState(() {
        _completedTaskList = taskListModel.TaskList ?? [];
        _getCompletedTaskListInProgress = false;
      });
    } else {
      setState(() => _getCompletedTaskListInProgress = false);
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
