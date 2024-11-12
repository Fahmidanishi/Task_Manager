import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProcess = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCancelledTaskInProcess,
      replacement: CenteredCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          await _getCancelledTaskList();
        },
        child: ListView.separated(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: TaskCard(
                taskModel: _cancelledTaskList[index],
                onRefreshList: _getCancelledTaskList,
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

  Future<void> _getCancelledTaskList() async {
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.cancelledTaskList);

    if (response.isSuccess) {
      debugPrint('Cancelled Task Response: ${response.responseData}');
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      setState(() {});
      debugPrint('Number of Cancelled Tasks: ${_cancelledTaskList.length}');
    } else {
      setState(() => _getCancelledTaskInProcess = false);
      showSnackBarMessage(context, 'There seems to be a mistake.', true);
    }
  }
}
