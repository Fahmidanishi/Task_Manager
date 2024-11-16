import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/models/task_model.dart';
import '../controllers/task_update_controller.dart';

class TaskUpdate extends StatefulWidget {
  const TaskUpdate({
    super.key,
    required this.taskModel,
    required this.onRefresh,
  });

  final TaskModel taskModel;
  final VoidCallback onRefresh;

  @override
  State<TaskUpdate> createState() => _TaskUpdateState();
}

class _TaskUpdateState extends State<TaskUpdate> {
  String _selectedTask = '';

  final TaskUpdateController _taskUpdateController =
  Get.find<TaskUpdateController>();

  @override
  void initState() {
    super.initState();
    _selectedTask = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[200],
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const Divider(),
                      Column(
                        children: ['New', 'Completed', 'Progress', 'Canceled']
                            .map(
                              (e) => ListTile(
                            onTap: () {
                              _updateTask(e);
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            },
                            title: Text(e),
                            selected: _selectedTask == e,
                            trailing: _selectedTask == e
                                ? const Icon(Icons.check)
                                : null,
                          ),
                        )
                            .toList(),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: const Icon(
        Icons.edit_attributes_outlined,
        color: Colors.blue,
      ),
    );
  }

  Future<void> _updateTask(String status) async {
    final bool result = await _taskUpdateController.updateTask(
      widget.taskModel.sId!,
      status,
    );
    if (result) {
      widget.onRefresh();
      snackMassage(false, 'Task Updated');
    } else {
      snackMassage(true, _taskUpdateController.errorMessage!);
    }
  }
}