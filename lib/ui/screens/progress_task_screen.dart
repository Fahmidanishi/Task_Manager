import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';
import 'package:task_manager/ui/utills/app_padding.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card_section.dart';

import '../widgets/tm_process_indicator.dart';


class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
  Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          _getProgressTask();
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(
              AppPadding.defaultPadding,
            ),
            child: Expanded(
              child: GetBuilder<ProgressTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const TMProgressIndicator(),
                    child: ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        return TaskCardSection(
                          taskModel: controller.taskList[index],
                          onRefresh: _getProgressTask,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressTask() async {
    final bool result = await _progressTaskController.getProgressTask();
    if (result == false) {
      snackMassage(true, _progressTaskController.errorMessage!);
    }
  }
}