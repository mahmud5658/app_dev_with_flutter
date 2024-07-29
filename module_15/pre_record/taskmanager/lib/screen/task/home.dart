import 'package:flutter/material.dart';
import 'package:taskmanager/component/app_bar.dart';
import 'package:taskmanager/component/bottom_nav.dart';
import 'package:taskmanager/component/cancel_task.dart';
import 'package:taskmanager/component/complete_task.dart';
import 'package:taskmanager/component/new_task.dart';
import 'package:taskmanager/component/progress_tak.dart';
import 'package:taskmanager/utility/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;

  Map<String, String> profileData = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "photo": deImage
  };

  readProfileData() async {
    String? email = await readUserData('email');
    String? firstName = await readUserData('firstName');
    String? lastName = await readUserData('lastName');
    String? photo = await readUserData('photo');

    setState(() {
      profileData = {
        "email": "$email",
        "firstName": "$firstName",
        "lastName": "$lastName",
        "photo": "$photo"
      };
    });
  }

  @override
  void initState() {
    readProfileData();
    super.initState();
  }

  onItemTapped(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  final widgetsOptions = [
    const NewTaskList(),
    const ProgressTaskList(),
    const CompleteTaskList(),
    const CancelTaskList()
  ];
  @override
  Widget build(BuildContext context) {
    print(profileData['photo']);
    return Scaffold(
      appBar: taskappBar(context, profileData),
      body: widgetsOptions.elementAt(tabIndex),
      bottomNavigationBar: bottomNav(tabIndex, onItemTapped),
    );
  }
}
