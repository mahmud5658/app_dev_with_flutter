import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screen/task/cancel_task_screen.dart';
import 'package:taskmanager/ui/screen/task/completed_task_screen.dart';
import 'package:taskmanager/ui/screen/task/inprogress_task_screen.dart';
import 'package:taskmanager/ui/screen/task/new_task_screen.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/profile_app_bar.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          _selectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: "Completed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_rounded), label: "In Progress"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: "Canceled"),
        ],
      ),
    );
  }
}
