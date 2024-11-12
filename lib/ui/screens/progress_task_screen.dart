import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProcessTaskListInProcess = false;
  List<TaskModel> _processTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProcessTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getProcessTaskListInProcess,
      replacement: const CenteredCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: _getProcessTaskList,
        child: _processTaskList.isEmpty
            ? const Center(child: Text('No tasks in progress'))
            : ListView.separated(
          itemCount: _processTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: TaskCard(
                taskModel: _processTaskList[index],
                onRefreshList: _getProcessTaskList,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getProcessTaskList() async {
    setState(() {
      _processTaskList.clear();
      _getProcessTaskListInProcess = true;
    });

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progressTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);

      setState(() {
        _processTaskList = taskListModel.TaskList ?? [];
        _getProcessTaskListInProcess = false;
      });
    } else {
      setState(() => _getProcessTaskListInProcess = false);
      showSnackBarMessage(context, 'There seems to be a mistake.', true);
    }
  }

  Future<void> _onTapAddFAB() async {
    // Navigate to AddNewTaskScreen and refresh the task list if a new task is added
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );

    // Refresh the task list if a new task was added
    if (shouldRefresh == true) {
      _getProcessTaskList();
    }
  }
}
