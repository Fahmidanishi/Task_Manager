import 'package:flutter/material.dart';

import '../utills/app_colors.dart';

class TMBottomNavBar extends StatelessWidget {
  const TMBottomNavBar(
      {super.key, required this.selectedIndex, required this.onTapChange,});

  final int selectedIndex;
  final void Function(int) onTapChange;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onTapChange,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.task_outlined,
          ),
          selectedIcon: Icon(
            Icons.task_outlined,
            color: AppColors.foregroundColor,
          ),
          label: 'New',
        ),
        NavigationDestination(
          icon: Icon(Icons.task_outlined),
          selectedIcon: Icon(
            Icons.task_outlined,
            color: AppColors.foregroundColor,
          ),
          label: 'Completed',
        ),
        NavigationDestination(
          icon: Icon(Icons.task_outlined),
          selectedIcon: Icon(
            Icons.task_outlined,
            color: AppColors.foregroundColor,
          ),
          label: 'Cancel',
        ),
        NavigationDestination(
          icon: Icon(Icons.task_outlined),
          selectedIcon: Icon(
            Icons.task_outlined,
            color: AppColors.foregroundColor,
          ),
          label: 'Progress',
        ),
      ],
    );
  }
}