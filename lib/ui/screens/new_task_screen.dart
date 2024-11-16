import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_count_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utills/app_colors.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';

import '../../data/models/count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../widgets/snack_bar_message.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskModel> _newTaskList = [];
  List<Count> _taskCountList = [];
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() => inProgress = true);
    await Future.wait([
      _getNewTaskList(),
      _getListCount(),
    ]);
    setState(() => inProgress = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundColor,
        onPressed: _onTapFAB,
        child: const Icon(
          Icons.add,
          color: AppColors.foregroundColor,
        ),
      ),
      body: Visibility(
        visible: !inProgress,
        replacement: const Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async {
            _refreshData();
          },
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children:[..._taskCountList.map((e){
                      return SummaryCard(count: e.sum ?? 0, title: e.sId ?? '');
                    })],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _newTaskList[index],
                        onTapRefresh: _getNewTaskList,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _refreshData();

    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    inProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.newTaskList,
    );

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseBody);

      _newTaskList = taskListModel.taskList ?? [];
    } else {
      snackBarMessage(context, response.errorMessage, true);
    }
    inProgress = false;
    setState(() {});
  }

  Future<void> _getListCount() async {
    _taskCountList.clear();
    inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListCount);
    if (response.isSuccess) {
      final TaskListCountModel taskListCountModel = TaskListCountModel.fromJson(
          response.responseBody);
      _taskCountList = taskListCountModel.countList ?? [];
    } else {
      snackBarMessage(context, response.errorMessage, true);
      inProgress = false;
      setState(() {});
    }
  }
}