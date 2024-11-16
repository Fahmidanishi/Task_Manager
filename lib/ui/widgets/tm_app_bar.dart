import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/profile_update_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';


class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBar({super.key, this.isProfile = true});

  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    final image = AuthController.userData?.photo;
    return AppBar(
      backgroundColor: isProfile ? Colors.grey[400] : Colors.grey[300],
      title: isProfile
          ? ListTile(
        onTap: () {
          Get.toNamed(ProfileUpdateScreen.name);
        },
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 30,
          backgroundImage: image != null ? NetworkImage(image) : null,
          child: image == null
              ? Icon(
            Icons.person,
            size: 44,
            color: Colors.grey[400],
          )
              : null,
        ),
        title: Text(
          AuthController.userData?.fullName ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          AuthController.userData?.email ?? '',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        trailing: IconButton(
            onPressed: () async {
              await AuthController.clearAccessToken();
              Get.offAllNamed(SingInScreen.name);
            },
            icon: const Icon(Icons.logout)),
      )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}