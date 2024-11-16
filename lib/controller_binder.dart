import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_controller.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/otp_verify_controller.dart';
import 'package:task_manager/ui/controllers/password_controller.dart';
import 'package:task_manager/ui/controllers/profile_update_controller.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
import 'package:task_manager/ui/controllers/task_delete_controller.dart';
import 'package:task_manager/ui/controllers/task_status_controller.dart';
import 'package:task_manager/ui/controllers/task_update_controller.dart';
import 'package:task_manager/ui/controllers/verify_email_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SingInController());
    Get.put(SingUpController());
    Get.put(VerifyEmailController());
    Get.put(OTPVerifyController());
    Get.put(PasswordController());
    Get.put(ProfileUpdateController());
    Get.put(NewTaskController());
    Get.put(TaskDeleteController());
    Get.put(AddNewController());
    Get.put(TaskUpdateController());
    Get.put(CompletedTaskController());
    Get.put(CancelTaskController());
    Get.put(ProgressTaskController());
    Get.put(TaskStatusController());
  }

}