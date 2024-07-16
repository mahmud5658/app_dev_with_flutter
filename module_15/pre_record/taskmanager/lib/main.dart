import 'package:flutter/material.dart';
import 'package:taskmanager/app.dart';
import 'package:taskmanager/utility/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await readUserData('token');

  if (token==null) {
    runApp(const TaskManager(
      firstRoute: '/login',
    ));
  } else {
    runApp(const TaskManager(firstRoute: '/new_task'));
  }
}
