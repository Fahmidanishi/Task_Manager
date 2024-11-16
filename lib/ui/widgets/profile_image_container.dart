import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/controllers/profile_update_controller.dart';


class ProfileImageContainer extends StatefulWidget {
  const ProfileImageContainer({super.key});

  @override
  State<ProfileImageContainer> createState() => _ProfileImageContainerState();
}

class _ProfileImageContainerState extends State<ProfileImageContainer> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[600],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.grey[200],
          maxRadius: 54,
          backgroundImage: _selectedImage != null
              ? FileImage(_selectedImage!)
              : (AuthController.userData?.photo != null &&
              AuthController.userData!.photo!.isNotEmpty)
              ? NetworkImage(AuthController.userData!.photo!) as ImageProvider
              : null,
          child: (_selectedImage == null &&
              (AuthController.userData?.photo == null ||
                  AuthController.userData!.photo!.isEmpty))
              ? Icon(
            Icons.person,
            size: 98,
            color: Colors.grey[400],
          )
              : null,

        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickImage =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      _selectedImage = File(pickImage.path);
      setState(() {});

      Get.find<ProfileUpdateController>().setImage(_selectedImage!);
    }
  }
}