import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/utills/app_padding.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card_section.dart';

import '../widgets/tm_process_indicator.dart';


class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final CancelTaskController _cancelTaskController =
  Get.find<CancelTaskController>();

  @override
  void initState() {
    super.initState();
    _getCanceledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<CancelTaskController>(builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const TMProgressIndicator(),
                child: ListView.separated(
                  itemCount: _cancelTaskController.taskList.length,
                  itemBuilder: (context, index) {
                    return TaskCardSection(
                        taskModel: _cancelTaskController.taskList[index],
                        onRefresh: _getCanceledTask);
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

  Future<void> _getCanceledTask() async {
    final bool result = await _cancelTaskController.getCancelTask();
    if (result == false) {
      snackMassage(true, _cancelTaskController.errorMessage!);
    }
  }
}