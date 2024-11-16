import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/tm_process_indicator.dart';

import '../controllers/new_task_controller.dart';
import '../controllers/task_status_controller.dart';
import '../utills/app_padding.dart';
import '../widgets/task_card_section.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  final TaskStatusController _taskStatusController =
  Get.find<TaskStatusController>();

  @override
  void initState() {
    super.initState();
    _getNewTask();
    _getTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTask();
          _getTaskStatus();
        },
        child: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<TaskStatusController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const TMProgressIndicator(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: Row(
                          children: controller.taskCountList
                              .map(
                                (e) => SummaryCard(taskCountModel: e),
                          )
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Expanded(
                child: GetBuilder<NewTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const TMProgressIndicator(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.defaultPadding),
                        child: ListView.separated(
                          itemCount: controller.taskList.length,
                          itemBuilder: (context, index) {
                            return TaskCardSection(
                              taskModel: controller.taskList[index],
                              onRefresh: _getNewTask,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        final bool result = await Get.toNamed(AddNewScreen.name);
        if (result == true) {
          _getNewTask();
        }
      },
      elevation: 0,
      backgroundColor: Colors.grey[600],
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Future<void> _getNewTask() async {
    final bool result = await _newTaskController.getNewTask();
    if (result == false) {
      snackMassage(true, _newTaskController.errorMessage!);
    }
  }

  Future<void> _getTaskStatus() async {
    final bool result = await _taskStatusController.getStatusCount();
    if (result == false) {
      snackMassage(true, _taskStatusController.errorMessage!);
    }
  }
}