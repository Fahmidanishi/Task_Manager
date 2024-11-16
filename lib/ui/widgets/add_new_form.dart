import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_controller.dart';


import 'snack_bar_message.dart';
import 'tm_process_indicator.dart';

class AddNewForm extends StatefulWidget {
  const AddNewForm({super.key});

  @override
  State<AddNewForm> createState() => _AddNewFormState();
}

class _AddNewFormState extends State<AddNewForm> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
  TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AddNewController _addNewController = Get.find<AddNewController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.sizeOf(context);
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.036),
          Text(
            'Add new task',
            style: textTheme.displayMedium,
          ),
          SizedBox(height: size.height * 0.026),
          TextFormField(
            controller: _titleTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Enter valid value';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.010),
          TextFormField(
            controller: _descriptionTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'description',
            ),
            maxLines: 5,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Enter valid value';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.026),
          GetBuilder<AddNewController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const TMProgressIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapNextScreen,
                  child: const Text('Add'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTapNextScreen() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _addNewTask();
  }

  Future<void> _addNewTask() async {
    final bool result = await _addNewController.addNewTask(
      _titleTEController.text.trim(),
      _descriptionTEController.text.trim(),
    );
    if (result) {
      Get.back(result: true);
      snackMassage(false, 'New task added');
    } else {
      snackMassage(true, _addNewController.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}