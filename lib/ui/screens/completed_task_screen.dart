import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/utills/app_padding.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card_section.dart';

import '../widgets/tm_process_indicator.dart';


class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _completedTaskController =
  Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<CompletedTaskController>(builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const TMProgressIndicator(),
                child: ListView.separated(
                  itemCount: _completedTaskController.taskList.length,
                  itemBuilder: (context, index) {
                    return TaskCardSection(
                        taskModel: _completedTaskController.taskList[index],
                        onRefresh: _getNewTask);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _getNewTask() async {
    final bool result = await _completedTaskController.getCompletedTask();
    if (result == false) {
      snackMassage(true, _completedTaskController.errorMessage!);
    }
  }
}