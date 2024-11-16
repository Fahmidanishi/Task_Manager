import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/widgets/TM_app_bar.dart';
import 'package:task_manager/ui/widgets/tm_bottom_nav_app_bar.dart';

import 'cancel_task_screen.dart';

class MainButtonNavScreen extends StatefulWidget {
  const MainButtonNavScreen({super.key});

  @override
  State<MainButtonNavScreen> createState() => _MainButtonNavScreenState();
}

class _MainButtonNavScreenState extends State<MainButtonNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: TMBottomNavBar(
        selectedIndex: _selectedIndex,
        onTapChange: (int newValue) {
          _selectedIndex = newValue;
          setState(() {});
        },
      ),
    );
  }
}